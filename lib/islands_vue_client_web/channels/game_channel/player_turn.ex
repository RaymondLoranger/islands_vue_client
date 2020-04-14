defmodule Islands.Vue.ClientWeb.GameChannel.PlayerTurn do
  import Islands.Vue.ClientWeb.GameChannel.Event, only: [push: 3]

  alias Islands.Client.State
  alias Islands.{Board, Engine, Tally}
  alias Islands.Vue.ClientWeb.GameChannel.RandomGuess
  alias Phoenix.Socket

  @spec handle_info(Socket.t()) :: {:noreply, Socket.t()}
  def handle_info(
        %Socket{
          assigns: %{
            player_state: %State{
              game_name: game_name,
              player_name: player_name,
              player_id: player_id,
              mode: mode
            }
          }
        } = socket
      ) do
    case Engine.tally(game_name, player_id) do
      %Tally{} = tally ->
        push(:game_state, socket, {tally.game_state})

        case tally.request do
          {:set_islands, :player1} ->
            push(:opponent_set_islands, socket, {})
            push(:wait_for_make_move, socket, {player_name})

          {:set_islands, :player2} ->
            push(:opponent_set_islands, socket, {})
            push(:please_make_move, socket, {player_name})

          {:guess_coord, _player_id, row, col} ->
            push(:please_make_move, socket, {player_name})
            push(:board_score, socket, tally.board_score)

            case tally.response do
              {:hit, island_type, :no_win} ->
                push(:opponent_hit, socket, {row, col, island_type})
                push(:island_hits, socket, Board.hit_cells(tally.board))

              {:miss, :none, :no_win} ->
                push(:opponent_missed, socket, {row, col})
                push(:island_misses, socket, Board.miss_squares(tally.board))
            end
        end

        case mode do
          :auto -> RandomGuess.handle_in(%{}, socket)
          :manual -> {:noreply, socket}
        end

      _error ->
        push(:game_not_found, socket, {game_name})
        {:noreply, socket}
    end
  end
end
