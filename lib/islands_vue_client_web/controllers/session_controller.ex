defmodule Islands.Vue.ClientWeb.SessionController do
  use Islands.Vue.ClientWeb, :controller

  alias Islands.Player

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"player" => %{"name" => name, "gender" => gender}}) do
    this = self()
    player = Player.new(name, gender, this)

    conn
    |> put_session(:current_player, player)
    |> redirect_back_or_to_new_game
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_player)
    |> redirect(to: "/")
  end

  ## Private functions

  defp redirect_back_or_to_new_game(conn) do
    path = get_session(conn, :return_to) || game_path(conn, :new)

    conn
    |> put_session(:return_to, nil)
    |> redirect(to: path)
  end
end
