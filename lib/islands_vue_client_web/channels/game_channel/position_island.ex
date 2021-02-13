defmodule Islands.Vue.ClientWeb.GameChannel.PositionIsland do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.{Engine, Island, Tally}
  alias Islands.Vue.Client.Player
  alias Phoenix.Socket

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        %{
          "islandId" => island_id,
          "position" => %{"gridColumnStart" => col, "gridRowStart" => row}
        } = _payload,
        %Socket{
          assigns: %{
            player: %Player{
              game_name: game_name,
              player_id: player_id
            }
          }
        } = socket
      ) do
    type = String.to_atom(island_id)

    case Engine.position_island(game_name, player_id, type, row, col) do
      %Tally{} = tally ->
        push(:game_state, socket, {tally.game_state})

        case tally.response do
          {:ok, :all_islands_positioned} ->
            push(:island_positioned, socket, {island_id, row, col})

          {:error, :islands_already_set} ->
            push(:islands_already_set, socket, {})

          {:error, :overlapping_island} ->
            push(:overlapping_island, socket, {island_id, row, col})

          {:error, :invalid_coordinates} ->
            push(:invalid_coordinates, socket, {island_id, row, col})

          {:error, :invalid_island_location} ->
            push(:invalid_island_location, socket, {island_id, row, col})

          {:error, reason} ->
            push(:error, socket, {reason})
        end

        push(:island_position, socket, %{
          "islandId" => type,
          "position" => Island.grid_position(tally.board.islands[type])
        })

      _error ->
        broadcast!(:game_not_found, socket, {game_name})
    end

    {:noreply, socket}
  end
end
