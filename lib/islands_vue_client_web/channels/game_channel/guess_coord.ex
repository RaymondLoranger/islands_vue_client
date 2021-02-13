defmodule Islands.Vue.ClientWeb.GameChannel.GuessCoord do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.{Coord, Engine, Guesses, Tally}
  alias Islands.Vue.Client.Player
  alias Phoenix.Socket

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        %{"square" => square} = _payload,
        %Socket{
          assigns: %{
            player: %Player{
              game_name: game_name,
              player_name: player_name,
              player_id: player_id
            }
          }
        } = socket
      ) do
    {:ok, %Coord{row: row, col: col}} = Coord.new(square)

    case Engine.guess_coord(game_name, player_id, row, col) do
      %Tally{} = tally ->
        push(:game_state, socket, {tally.game_state})

        case tally.response do
          {:hit, island_type, win_check} ->
            push(:you_hit, socket, {row, col, island_type})

            case win_check do
              :no_win ->
                push(:wait_for_make_move, socket, {player_name})

              :win ->
                push(:new_game, socket, {player_name})
                push(:you_won, socket, {player_name})
            end

            push(:guesses_score, socket, tally.guesses_score)
            push(:guesses_hits, socket, Guesses.hit_squares(tally.guesses))

          {:miss, :none, :no_win} ->
            push(:you_missed, socket, {row, col})
            push(:wait_for_make_move, socket, {player_name})
            push(:guesses_score, socket, tally.guesses_score)
            push(:guesses_misses, socket, Guesses.miss_squares(tally.guesses))

          {:error, :player2_not_added} ->
            push(:player2_not_added, socket, {player_name})

          {:error, :not_both_players_islands_set} ->
            push(:not_both_players_islands_set, socket, {})

          {:error, :not_player_turn} ->
            push(:not_your_turn, socket, {})

          {:error, :game_over} ->
            broadcast!(:game_over, socket, {game_name})

          {:error, reason} ->
            push(:error, socket, {reason})
        end

      _error ->
        broadcast!(:game_not_found, socket, {game_name})
    end

    {:noreply, socket}
  end
end
