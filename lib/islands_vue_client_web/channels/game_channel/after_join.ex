defmodule Islands.Vue.ClientWeb.GameChannel.AfterJoin do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.{Board, Engine, Tally}
  alias Islands.Vue.Client.Player
  alias Islands.Vue.ClientWeb.Presence
  alias Phoenix.Socket

  @spec handle_info(Socket.t()) :: {:noreply, Socket.t()}
  def handle_info(
        %Socket{
          assigns: %{
            player: %Player{
              game_name: game_name,
              player_name: player_name,
              gender: gender,
              player_id: :player1
            }
          }
        } = socket
      ) do
    case Engine.tally(game_name, :player1) do
      %Tally{} = tally ->
        push(:please_invite, socket, {player_name})
        push(:game_state, socket, {tally.game_state})
        push(:player_state, socket, {:player1, tally})
        push(:board_score, socket, tally.board_score)
        push(:guesses_score, socket, tally.guesses_score)
        push(:presence_state, socket, Presence.list(socket))
        push(:presence_diff, socket, {:player1, player_name, gender})

      _error ->
        {:error, reason(:game_crashed, {game_name})}
    end

    {:noreply, socket}
  end

  def handle_info(
        %Socket{
          assigns: %{
            player: %Player{
              game_name: game_name,
              player_name: player_name,
              gender: gender,
              player_id: :player2
            }
          }
        } = socket
      ) do
    case Engine.position_all_islands(game_name, :player2) do
      %Tally{} = tally ->
        push(:you_joined, socket, {player_name, tally.guesses_score.name})
        push(:please_set_islands, socket, {player_name})
        push(:game_state, socket, {tally.game_state})
        push(:player_state, socket, {:player2, tally})
        push(:island_positions, socket, Board.grid_positions(tally.board))
        push(:board_score, socket, tally.board_score)
        push(:guesses_score, socket, tally.guesses_score)
        push(:presence_state, socket, Presence.list(socket))
        push(:presence_diff, socket, {:player2, player_name, gender})

      _error ->
        {:error, reason(:game_crashed, {game_name})}
    end

    {:noreply, socket}
  end

  # Private functions

  @spec reason(atom, tuple) :: map
  defp reason(:game_crashed, {game_name}) do
    %{
      reason: """
      Game <span class="distinct">#{game_name}</span> crashed!
      """
    }
  end
end
