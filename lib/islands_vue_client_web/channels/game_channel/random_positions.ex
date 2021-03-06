defmodule Islands.Vue.ClientWeb.GameChannel.RandomPositions do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.{Board, Engine, Tally}
  alias Islands.Vue.Client.Player
  alias Phoenix.Socket

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        payload,
        %Socket{
          assigns: %{
            player: %Player{game_name: game_name, player_id: player_id}
          }
        } = socket
      )
      when payload == %{} do
    case Engine.position_all_islands(game_name, player_id) do
      %Tally{} = tally ->
        push(:game_state, socket, {tally.game_state})

        case tally.response do
          {:ok, :all_islands_positioned} ->
            push(:all_positioned, socket, {})
            push(:island_positions, socket, Board.grid_positions(tally.board))

          {:error, :islands_already_set} ->
            push(:islands_already_set, socket, {})

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
