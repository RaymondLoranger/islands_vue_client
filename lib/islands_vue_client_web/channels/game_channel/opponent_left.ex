defmodule Islands.Vue.ClientWeb.GameChannel.OpponentLeft do
  import Islands.Vue.ClientWeb.GameChannel.Event, only: [push: 3]

  alias Islands.Client.State
  alias Phoenix.Socket

  require Logger

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        payload,
        %Socket{
          assigns: %{
            player_state: %State{game_name: game_name, player_name: player_name}
          }
        } = socket
      )
      when payload == %{} do
    push(:opponent_left, socket, {player_name})
    push(:new_game, socket, {player_name})
    push(:game_ended, socket, {game_name})
    {:noreply, socket}
  end
end
