defmodule Islands.Vue.ClientWeb.GameChannel.SwitchMode do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.Vue.Client.Player
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
        socket.assigns.player,
        &Player.switch_mode(&1, mode, pause)
      )

    push(:set_mode, socket, {mode})

    case mode do
      :auto -> RandomGuess.handle_in(%{}, socket)
      :manual -> {:noreply, socket}
    end
  end
end
