defmodule Islands.Vue.ClientWeb.SessionController do
  use Islands.Vue.ClientWeb, :controller

  alias Islands.Player

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"player" => %{"name" => name, "gender" => gender}}) do
    player = Player.new(name, String.to_atom(gender), self(), basic: true)

    conn
    |> put_session(:player, player)
    |> redirect_back_or_to_new_game
  end

  ## Private functions

  defp redirect_back_or_to_new_game(conn) do
    # Nil 'return_to' path if going to '/sessions/new' instead of '/games/new'.
    path = get_session(conn, :return_to) || game_path(conn, :new)

    conn
    |> delete_session(:return_to)
    |> redirect(to: path)
  end
end
