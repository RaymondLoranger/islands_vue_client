defmodule Islands.Vue.ClientWeb.UserSocket do
  use Phoenix.Socket

  @salt Application.get_env(:islands_vue_client, :salt)

  ## Channels
  channel "games:*", Islands.Vue.ClientWeb.GameChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.

  # Verify the token which should return the `client state`, and then
  # assign that `state` to the socket. This allows us to reference
  # the `state` in the callback functions of the channel module.
  #
  # max_age: 86400 is equivalent to one day in seconds
  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, @salt, token, max_age: 86400) do
      {:ok, player_state} -> {:ok, assign(socket, :player_state, player_state)}
      {:error, _reason} -> :error
    end
  end

  def connect(_params, _socket), do: :error

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Islands.Vue.ClientWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
