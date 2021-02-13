defmodule Islands.Vue.ClientWeb.GameChannel.PlayersSet do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.{Board, Engine, Tally}
  alias Islands.Vue.Client.Player
  alias Phoenix.Socket

  @spec handle_info(Socket.t()) :: {:noreply, Socket.t()}
  def handle_info(
        %Socket{
          assigns: %{
            player: %Player{
              game_name: game_name,
              player_name: player_name,
              player_id: :player1
            }
          }
        } = socket
      ) do
    case Engine.tally(game_name, :player1) do
      %Tally{} = tally ->
        case tally.response do
          {:ok, :player2_added} ->
            tally = Engine.position_all_islands(game_name, :player1)
            opponent_name = tally.guesses_score.name
            push(:game_state, socket, {tally.game_state})
            push(:island_positions, socket, Board.grid_positions(tally.board))
            push(:guesses_score, socket, tally.guesses_score)
            push(:opponent_joined, socket, {player_name, opponent_name})
            push(:please_set_islands, socket, {player_name})

          {:ok, :islands_set} ->
            push(:opponent_set_islands, socket, {})
        end

      _error ->
        broadcast!(:game_not_found, socket, {game_name})
    end

    {:noreply, socket}
  end

  def handle_info(
        %Socket{
          assigns: %{player: %Player{player_id: :player2}}
        } = socket
      ) do
    push(:opponent_set_islands, socket, {})
    {:noreply, socket}
  end
end
