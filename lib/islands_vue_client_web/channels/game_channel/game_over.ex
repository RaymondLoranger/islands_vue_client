defmodule Islands.Vue.ClientWeb.GameChannel.GameOver do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.Client.State
  alias Islands.{Board, Engine, Tally}
  alias Islands.Vue.ClientWeb.GameChannel.GameEnder
  alias Phoenix.Socket

  require Logger

  @spec handle_info(Socket.t()) :: {:noreply, Socket.t()}
  def handle_info(
        %Socket{
          assigns: %{
            player_state: %State{
              game_name: game_name,
              player_name: player_name,
              player_id: player_id
            }
          }
        } = socket
      ) do
    case Engine.tally(game_name, player_id) do
      %Tally{} = tally ->
        push(:game_state, socket, {tally.game_state})
        push(:new_game, socket, {player_name})
        push(:board_score, socket, tally.board_score)
        push(:island_hits, socket, Board.hit_cells(tally.board))

        case tally.request do
          {:guess_coord, _player_id, row, col} ->
            {:hit, island_type, :win} = tally.response
            push(:opponent_hit, socket, {row, col, island_type})
            push(:you_lost, socket, {player_name})

          {:stop, _player_id} ->
            push(:opponent_stopped, socket, {player_name})
        end

        GameEnder.end_game(game_name)

      _error ->
        broadcast!(:game_not_found, socket, {game_name})
    end

    {:noreply, socket}
  end
end
