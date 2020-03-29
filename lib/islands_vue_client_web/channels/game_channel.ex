defmodule Islands.Vue.ClientWeb.GameChannel do
  use Islands.Vue.ClientWeb, :channel

  import __MODULE__.Event, only: [push: 3]
  import Phoenix.Channel, except: [push: 3]

  alias Islands.{Board, Coord, Engine, Island, Tally}
  alias Islands.Vue.ClientWeb.Presence
  alias Phoenix.Socket

  def join("games:" <> game_name, _payload, socket) do
    with pid when is_pid(pid) <- Engine.game_pid(game_name) do
      tally = Engine.tally(game_name, :player2)
      IO.inspect(tally, label: "++++ tally ++++")
      self() |> send({:after_join, game_name})
      {:ok, socket}
    else
      nil -> {:error, %{reason: "Game #{game_name} does not exist!"}}
    end
  end

  @spec handle_info(msg :: term, Socket.t()) :: {:noreply, Socket.t()}
  def handle_info({:after_join, game_name}, socket) do
    {_, player_name, player_id, gender} = player(socket)
    Engine.update_player(game_name, player_id, player_name, gender, self())
    tally = Engine.position_all_islands(game_name, player_id)
    IO.inspect(tally, label: ";;;; tally ;;;;")

    case player_id do
      :player1 ->
        push(:please_invite, socket, {player_name})

      :player2 ->
        push(:you_joined, socket, {player_name, tally.guesses_score.name})
        push(:please_set_islands, socket, {player_name})
    end

    push(:game_state, socket, {tally.game_state})
    push(:island_positions, socket, gridPositions(tally))
    push(:board_score, socket, tally.board_score)
    push(:guesses_score, socket, tally.guesses_score)
    push(:presence_state, socket, Presence.list(socket))
    push(:presence_diff, socket, {player_id, player_name, gender})
    {:noreply, socket}
  end

  def handle_info(:players_set, socket) do
    {game_name, player_name, player_id, _} = player(socket)
    tally = Engine.tally(game_name, player_id)
    push(:game_state, socket, {tally.game_state})

    case tally.request do
      {:add_player, opponent_name, _gender, _pid} ->
        push(:guesses_score, socket, tally.guesses_score)
        push(:opponent_joined, socket, {player_name, opponent_name})
        push(:please_set_islands, socket, {player_name})

      {:set_islands, _player_id} ->
        push(:opponent_set_islands, socket, {})
    end

    {:noreply, socket}
  end

  def handle_info(msg, socket) when msg in [:player1_turn, :player2_turn] do
    {game_name, player_name, player_id, _} = player(socket)
    tally = Engine.tally(game_name, player_id)
    push(:game_state, socket, {tally.game_state})

    case tally.request do
      {:set_islands, :player1} ->
        push(:opponent_set_islands, socket, {})
        push(:wait_for_make_guess, socket, {player_name})

      {:set_islands, :player2} ->
        push(:opponent_set_islands, socket, {})
        push(:please_make_guess, socket, {player_name})

      {:guess_coord, _player_id, row, col} ->
        case tally.response do
          {:hit, island_type, :no_win} ->
            push(:opponent_hit, socket, {row, col, island_type})
            push(:please_make_guess, socket, {player_name})
            push(:board_score, socket, tally.board_score)
            push(:island_hits, socket, island_hits(tally))

          {:miss, :none, :no_win} ->
            push(:opponent_missed, socket, {row, col})
            push(:please_make_guess, socket, {player_name})
            push(:board_score, socket, tally.board_score)
            push(:island_misses, socket, island_misses(tally))
        end
    end

    {:noreply, socket}
  end

  def handle_info(:game_over, socket) do
    {game_name, player_name, player_id, _} = player(socket)
    tally = Engine.tally(game_name, player_id)
    push(:game_state, socket, {tally.game_state})
    IO.inspect(tally, label: "\\m/ tally \\m/")
    {:guess_coord, _player_id, row, col} = tally.request
    {:hit, island_type, :win} = tally.response
    push(:opponent_hit, socket, {row, col, island_type})
    push(:new_game, socket, {player_name})
    push(:you_lost, socket, {player_name})
    push(:board_score, socket, tally.board_score)
    push(:island_hits, socket, island_hits(tally))
    {:noreply, socket}
  end

  @spec handle_in(event :: String.t(), payload :: map, socket :: Socket.t()) ::
          {:noreply, Socket.t()}
  def handle_in("random_positions", %{}, socket) do
    {game_name, _, player_id, _} = player(socket)
    tally = Engine.position_all_islands(game_name, player_id)
    push(:game_state, socket, {tally.game_state})

    case tally.response do
      {:ok, :all_islands_positioned} ->
        push(:all_positioned, socket, {})
        push(:island_positions, socket, gridPositions(tally))

      {:error, :islands_already_set} ->
        push(:islands_already_set, socket, {})

      {:error, :game_over} ->
        push(:game_over, socket, {})

      {:error, reason} ->
        push(:error, socket, {reason})
    end

    {:noreply, socket}
  end

  def handle_in("set_islands", %{}, socket) do
    {game_name, player_name, player_id, _} = player(socket)
    tally = Engine.set_islands(game_name, player_id)
    push(:game_state, socket, {tally.game_state})
    IO.inspect(tally, label: "---- tally ----")
    opponent_gender = tally.guesses_score.gender

    case tally.game_state do
      :initialized ->
        push(:player2_not_added, socket, {player_name})

      :players_set ->
        push(:you_set_islands, socket, {})
        push(:wait_for_set_islands, socket, {player_name, opponent_gender})

      :player1_turn ->
        case tally.response do
          {:ok, :islands_set} ->
            push(:you_set_islands, socket, {})

            case player_id do
              :player1 -> push(:please_make_guess, socket, {player_name})
              :player2 -> push(:wait_for_make_guess, socket, {player_name})
            end

          {:error, :both_players_islands_set} ->
            push(:both_players_islands_set, socket, {})

          {:error, reason} ->
            push(:error, socket, {reason})
        end

      :player2_turn ->
        push(:both_players_islands_set, socket, {})

      :game_over ->
        push(:game_over, socket, {})
    end

    {:noreply, socket}
  end

  def handle_in("position_island", payload, socket) do
    {game_name, _, player_id, _} = player(socket)
    %{"islandId" => id, "position" => position} = payload
    %{"gridColumnStart" => col, "gridRowStart" => row} = position
    tally = Engine.position_island(game_name, player_id, :"#{id}", row, col)
    push(:game_state, socket, {tally.game_state})
    IO.inspect(tally, label: ":::: tally ::::")

    case tally.response do
      {:ok, :all_islands_positioned} ->
        push(:island_positioned, socket, {id, row, col})
        push(:island_positions, socket, gridPositions(tally))

      {:error, :islands_already_set} ->
        push(:islands_already_set, socket, {})
        push(:island_positions, socket, gridPositions(tally))

      {:error, :overlapping_island} ->
        push(:overlapping_island, socket, {id, row, col})
        push(:island_positions, socket, gridPositions(tally))

      {:error, :invalid_coordinates} ->
        push(:invalid_coordinates, socket, {id, row, col})
        push(:island_positions, socket, gridPositions(tally))

      {:error, reason} ->
        push(:error, socket, {reason})
        push(:island_positions, socket, gridPositions(tally))
    end

    {:noreply, socket}
  end

  def handle_in("guess_coord", %{"square" => square}, socket) do
    {game_name, player_name, player_id, _} = player(socket)
    {row, col} = row_col(square)
    tally = Engine.guess_coord(game_name, player_id, row, col)
    push(:game_state, socket, {tally.game_state})
    IO.inspect(tally, label: "???? tally ????")

    case tally.response do
      {:hit, island_type, win_check} ->
        push(:you_hit, socket, {row, col, island_type})

        case win_check do
          :no_win ->
            push(:wait_for_make_guess, socket, {player_name})

          :win ->
            push(:new_game, socket, {player_name})
            push(:you_won, socket, {player_name})
        end

        push(:guesses_score, socket, tally.guesses_score)
        hits = %{squares: Enum.map(tally.guesses.hits, &coord_to_square/1)}
        push(:guesses_hits, socket, hits)

      {:miss, :none, :no_win} ->
        push(:you_missed, socket, {row, col})
        push(:wait_for_make_guess, socket, {player_name})
        push(:guesses_score, socket, tally.guesses_score)
        misses = %{squares: Enum.map(tally.guesses.misses, &coord_to_square/1)}
        push(:guesses_misses, socket, misses)

      {:error, :player2_not_added} ->
        push(:player2_not_added, socket, {player_name})

      {:error, :not_both_players_islands_set} ->
        push(:not_both_players_islands_set, socket, {})

      {:error, :not_player_turn} ->
        push(:not_your_turn, socket, {})

      {:error, :game_over} ->
        push(:game_over, socket, {})

      {:error, reason} ->
        push(:error, socket, {reason})
    end

    {:noreply, socket}
  end

  def handle_in("new_chat_message", %{"body" => body}, socket) do
    {_, player_name, _, _} = player(socket)
    broadcast!(socket, "new_chat_message", %{sender: player_name, body: body})
    {:noreply, socket}
  end

  ## Private functions

  @spec player(Socket.t()) :: tuple
  defp player(%Socket{assigns: %{player_state: state}}) do
    {state.game_name, state.player_name, state.player_id, state.gender}
  end

  @spec island_hits(tally :: Tally.t()) :: map
  defp island_hits(%Tally{board: %Board{islands: islands}}) do
    for {type, island} <- islands, into: %{}, do: {type, hit_classes(island)}
  end

  @spec hit_classes(Island.t()) :: [<<_::2, _::_*8>>]
  defp hit_classes(%Island{hits: hits} = island) do
    origin = origin(island)
    Enum.map(hits, &hit_class(origin, &1))
  end

  @spec hit_class(origin :: Coord.t(), hit :: Coord.t()) :: <<_::16>>
  defp hit_class(%Coord{row: row_0, col: col_0}, %Coord{row: row, col: col}) do
    <<?a + col - col_0, ?1 + row - row_0>>
  end

  @spec row_col(square :: 1..100) :: {row :: 1..10, col :: 1..10}
  defp row_col(square), do: rem(square, 10) |> row_col(square)

  @spec row_col(rem :: 0..9, square :: 1..100) :: {row :: 1..10, col :: 1..10}
  defp row_col(0, square), do: {div(square, 10), 10}
  defp row_col(rem, square), do: {div(square, 10) + 1, rem}

  @spec island_misses(tally :: Tally.t()) :: map
  defp island_misses(%Tally{board: %Board{misses: misses}}) do
    %{squares: Enum.map(misses, &coord_to_square/1)}
  end

  @spec coord_to_square(Coord.t()) :: square :: 1..100
  defp coord_to_square(%Coord{row: row, col: col}), do: (row - 1) * 10 + col

  @spec gridPositions(tally :: Tally.t()) :: map
  defp gridPositions(%Tally{board: %Board{islands: islands}}) do
    for {type, island} <- islands, into: %{} do
      {type, island |> origin() |> gridPosition()}
    end
  end

  @spec gridPosition(origin :: Coord.t()) :: map
  defp gridPosition(%Coord{row: row, col: col}) do
    %{gridColumnStart: col, gridRowStart: row}
  end

  @spec origin(Island.t()) :: Coord.t()
  defp origin(%Island{type: :s_shape, coords: coords}) do
    %Coord{row: row, col: col} = top_left(coords)
    {:ok, coord} = Coord.new(row, col - 1)
    coord
  end

  defp origin(%Island{type: _type, coords: coords}), do: top_left(coords)

  @spec top_left(MapSet.t(Coord.t())) :: Coord.t()
  defp top_left(coords) do
    coords
    |> MapSet.to_list()
    |> Enum.sort_by(&{&1.row, &1.col})
    |> List.first()
  end
end
