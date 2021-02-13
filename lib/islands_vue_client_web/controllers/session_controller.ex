defmodule Islands.Vue.ClientWeb.SessionController do
  use Islands.Vue.ClientWeb, :controller

  alias Islands.Vue.Client.Player

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"player" => %{"name" => name, "gender" => gender}}) do
    player = Player.new(name, String.to_atom(gender))

    conn
    |> put_session(:player, player)
    |> redirect_back_or_to_new_game
  end

  ## Private functions

  defp redirect_back_or_to_new_game(conn) do
    # The 'return_to' path retrieved by 'get_session' will be nil if going
    # to '/sessions/new' directly instead of the usual '/' or '/games/new'.
    path = get_session(conn, :return_to) || Routes.game_path(conn, :new)

    conn
    |> delete_session(:return_to)
    |> redirect(to: path)
  end
end
