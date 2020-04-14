defmodule Islands.Vue.ClientWeb.GameChannel.SwitchMode do
  alias Islands.Client.State
  alias Islands.Vue.ClientWeb.GameChannel.RandomGuess
  alias Phoenix.Socket

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        %{"mode" => mode, "pause" => pause} = _payload,
        %Socket{} = socket
      ) do
    {mode, pause} = {String.to_atom(mode), String.to_integer(pause)}

    socket =
      update_in(
        socket.assigns.player_state,
        &%State{&1 | mode: mode, pause: pause}
      )

    case mode do
      :auto -> RandomGuess.handle_in(%{}, socket)
      :manual -> {:noreply, socket}
    end
  end
end
