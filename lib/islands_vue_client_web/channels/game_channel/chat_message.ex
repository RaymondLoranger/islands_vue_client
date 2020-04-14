defmodule Islands.Vue.ClientWeb.GameChannel.ChatMessage do
  import Phoenix.Channel, only: [broadcast!: 3]

  alias Islands.Client.State
  alias Phoenix.Socket

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        %{"body" => body} = _payload,
        %Socket{
          assigns: %{
            player_state: %State{player_name: player_name, gender: gender}
          }
        } = socket
      ) do
    broadcast!(socket, "chat_message", %{
      sender: player_name,
      gender: gender,
      body: body
    })

    {:noreply, socket}
  end
end
