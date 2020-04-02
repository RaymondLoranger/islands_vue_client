defmodule Islands.Vue.ClientWeb.GameChannel.Event do
  alias Islands.Vue.ClientWeb.Presence
  alias Phoenix.{Channel, Socket}

  @spec push(atom, Socket.t(), tuple | map) :: :ok
  def push(:game_state, socket, {game_state}) do
    :ok = Channel.push(socket, "game_state", %{game_state: game_state})
  end

  def push(:error, socket, {reason}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Error occurred. Reason ➜ #{inspect(reason)}.
        """
      })
  end

  def push(:islands_already_set, socket, {}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Islands ALREADY set.
        """
      })
  end

  def push(:overlapping_island, socket, {island_id, row, col}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Cannot position #{String.upcase(island_id)} at (#{row}, #{col}) ➜
        island overlap.
        """
      })
  end

  def push(:invalid_coordinates, socket, {island_id, row, col}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Cannot position #{String.upcase(island_id)} at (#{row}, #{col}) ➜
        invalid coordinates.
        """
      })
  end

  def push(:invalid_island_location, socket, {island_id, row, col}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Cannot position #{String.upcase(island_id)} at (#{row}, #{col}) ➜
        invalid location.
        """
      })
  end

  def push(:not_your_turn, socket, {}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        NOT your turn to make a guess!
        """
      })
  end

  def push(:player2_not_added, socket, {player_name}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        #{player_name}, first invite an opponent to join the game...
        """
      })
  end

  def push(:both_players_islands_set, socket, {}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Islands ALREADY set for for both players.
        """
      })
  end

  def push(:not_both_players_islands_set, socket, {}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Islands NOT YET set for for both players.
        """
      })
  end

  def push(:game_over, socket, {}) do
    :ok =
      Channel.push(socket, "error", %{
        reason: """
        Game is over!
        """
      })
  end

  def push(:you_set_islands, socket, {}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Islands set.
        """
      })
  end

  def push(:opponent_set_islands, socket, {}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Opponent's islands set.
        """
      })
  end

  def push(:please_set_islands, socket, {player_name}) do
    :ok =
      Channel.push(socket, "directive", %{
        text: """
        #{player_name}, please position your islands and hit 'Set Islands'.
        """
      })
  end

  def push(:all_positioned, socket, {}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        All islands randomly positioned.
        """
      })
  end

  def push(:please_invite, socket, {player_name}) do
    :ok =
      Channel.push(socket, "directive", %{
        text: """
        #{player_name}, please invite an opponent to join the game...
        """
      })
  end

  def push(:you_joined, socket, {player_name, opponent_name}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        #{player_name}, you've joined the game.
        Your opponent is #{opponent_name}.
        """
      })
  end

  def push(:opponent_joined, socket, {player_name, opponent_name}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        #{player_name}, your opponent, #{opponent_name}, has joined the game.
        """
      })
  end

  def push(:you_missed, socket, {row, col}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Your guess (#{row}, #{col}) ➜ miss.
        """
      })
  end

  def push(:opponent_missed, socket, {row, col}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Opponent's guess (#{row}, #{col}) ➜ miss.
        """
      })
  end

  def push(:opponent_hit, socket, {row, col, :none}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Opponent's guess (#{row}, #{col}) ➜ hit.
        """
      })
  end

  def push(:opponent_hit, socket, {row, col, island_type}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Opponent's guess (#{row}, #{col}) ➜
        #{island_type |> Atom.to_string() |> String.upcase()} forested.
        """
      })
  end

  def push(:you_hit, socket, {row, col, :none}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Your guess (#{row}, #{col}) ➜ hit.
        """
      })
  end

  def push(:you_hit, socket, {row, col, island_type}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Your guess (#{row}, #{col}) ➜
        #{island_type |> Atom.to_string() |> String.upcase()} forested.
        """
      })
  end

  def push(:you_lost, socket, {player_name}) do
    :ok =
      Channel.push(socket, "error", %{
        reason: """
        Sorry, #{player_name}, you lost.
        """
      })
  end

  def push(:you_won, socket, {player_name}) do
    :ok =
      Channel.push(socket, "error", %{
        reason: """
        Bravo, #{player_name}, you WON!
        """
      })
  end

  def push(:new_game, socket, {player_name}) do
    :ok =
      Channel.push(socket, "directive", %{
        text: """
        #{player_name}, you may hit 'New Game' if you wish.
        """
      })
  end

  def push(:wait_for_set_islands, socket, {player_name, gender}) do
    :ok =
      Channel.push(socket, "directive", %{
        text: """
        #{player_name}, please wait for your opponent
        to set #{adj(gender)} islands...
        """
      })
  end

  def push(:wait_for_make_guess, socket, {player_name}) do
    :ok =
      Channel.push(socket, "directive", %{
        text: """
        #{player_name}, please wait for your opponent to make a guess...
        """
      })
  end

  def push(:please_make_guess, socket, {player_name}) do
    :ok =
      Channel.push(socket, "directive", %{
        text: """
        #{player_name}, please make a guess...
        """
      })
  end

  def push(:island_positioned, socket, {island_id, row, col}) do
    :ok =
      Channel.push(socket, "response", %{
        text: """
        Island #{String.upcase(island_id)} positioned at (#{row}, #{col}).
        """
      })
  end

  def push(:board_score, socket, score) do
    :ok = Channel.push(socket, "board_score", score)
  end

  def push(:guesses_score, socket, score) do
    :ok = Channel.push(socket, "guesses_score", score)
  end

  def push(:island_positions, socket, positions) do
    :ok = Channel.push(socket, "island_positions", positions)
  end

  def push(:island_position, socket, position) do
    :ok = Channel.push(socket, "island_position", position)
  end

  def push(:presence_state, socket, presences) do
    :ok = Channel.push(socket, "presence_state", presences)
  end

  def push(:presence_diff, socket, {player_id, player_name, gender}) do
    {:ok, _ref} =
      Presence.track(socket, player_id, %{
        online_at: DateTime.utc_now() |> DateTime.to_string(),
        player_name: player_name,
        gender: gender
      })
  end

  def push(:island_hits, socket, hits) do
    :ok = Channel.push(socket, "island_hits", hits)
  end

  def push(:island_misses, socket, misses) do
    :ok = Channel.push(socket, "island_misses", misses)
  end

  def push(:guesses_hits, socket, hits) do
    :ok = Channel.push(socket, "guesses_hits", hits)
  end

  def push(:guesses_misses, socket, misses) do
    :ok = Channel.push(socket, "guesses_misses", misses)
  end

  ## Private functions

  @spec adj(atom) :: String.t()
  defp adj(:f), do: "her"
  defp adj(:m), do: "his"
end
