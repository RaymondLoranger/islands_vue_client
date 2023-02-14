defmodule Islands.Vue.ClientWeb.GameController do
  use Islands.Vue.ClientWeb, :controller

  alias Islands.Vue.Client.Player
  alias Islands.{Engine, Game}
  alias Phoenix.Token
  alias Plug.Conn

  @salt :application.get_env(:islands_vue_client, :salt)
  @salt elem(@salt, 1)

  plug :require_player when action != :index

  @spec index(Conn.t(), map) :: Conn.t()
  def index(conn, _params) do
    overviews = Engine.game_overviews()
    render conn, "index.html", overviews: overviews
  end

  @spec new(Conn.t(), map) :: Conn.t()
  def new(conn, _params) do
    game_name = Game.haiku_name()
    player = get_session(conn, :player) |> Player.update(game_name, :player1)

    conn
    # Allows next player to join game from other tabs of same browser...
    |> delete_session(:player)
    |> show(player)
  end

  @spec join(Conn.t(), map) :: Conn.t()
  def join(conn, %{"id" => game_name} = _params) do
    player = get_session(conn, :player) |> Player.update(game_name, :player2)

    conn
    # Allows next player to join game from other tabs of same browser...
    |> delete_session(:player)
    |> show(player)
  end

  ## Private functions

  @spec show(Conn.t(), Player.t()) :: Conn.t()
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

  @spec require_player(Conn.t(), any) :: Conn.t()
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

  @spec game_url(Conn.t(), Game.name()) :: String.t()
  defp game_url(conn, game_name) do
    req_headers = Map.new(conn.req_headers)
    req_headers["host"] <> Routes.game_path(conn, :join, game_name)
  end
end
