defmodule Islands.Vue.ClientWeb.GameChannel.Unexpected do
  import Islands.Vue.ClientWeb.GameChannel.Event, only: [push: 3]

  alias Phoenix.Socket

  @spec handle_info(msg :: term, Socket.t()) :: {:noreply, Socket.t()}
  def handle_info(msg, socket) do
    push(:unexpected_message, socket, {msg})
    {:noreply, socket}
  end

  @spec handle_in(event :: String.t(), map, Socket.t()) ::
          {:noreply, Socket.t()}
  def handle_in(event, payload, socket) do
    push(:unexpected_event, socket, {event, payload})
    {:noreply, socket}
  end
end
