defmodule Islands.Vue.ClientWeb.GameController do
  use Islands.Vue.ClientWeb, :controller

  alias Islands.Vue.Client.Player
  alias Islands.Vue.ClientWeb.Endpoint
  alias Islands.{Engine, Game}
  alias Phoenix.Token

  @salt Application.get_env(:islands_vue_client, :salt)

  plug :require_player when action != :index

  def index(conn, _params) do
    overviews = Engine.game_overviews()
    render conn, "index.html", overviews: overviews
  end

  def new(conn, _params) do
    game_name = Game.haiku_name()
    player = get_session(conn, :player) |> Player.update(game_name, :player1)

    conn
    # Allows next player to join game from other tabs of same browser...
    |> delete_session(:player)
    |> show(player)
  end

  def join(conn, %{"id" => game_name} = _params) do
    player = get_session(conn, :player) |> Player.update(game_name, :player2)

    conn
    # Allows next player to join game from other tabs of same browser...
    |> delete_session(:player)
    |> show(player)
  end

  ## Private functions

  defp show(
         conn,
         %Player{game_name: game_name, player_id: player_id} = player
       ) do
    conn
    |> assign(:player_id, player_id)
    |> assign(:game_url, game_url(conn, game_name))
    |> assign(:game_name, game_name)
    |> assign(:auth_token, Token.sign(conn, @salt, player))
    |> render("show.html")
  end

  defp require_player(conn, _opts) do
    case get_session(conn, :player) do
      nil ->
        conn
        |> put_session(:return_to, conn.request_path)
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()

      _player ->
        conn
    end
  end

  defp game_url(conn, game_name) do
    Endpoint.url() <> Routes.game_path(conn, :join, game_name)
  end
end
