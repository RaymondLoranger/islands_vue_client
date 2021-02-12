defmodule Islands.Vue.ClientWeb.GameController do
  use Islands.Vue.ClientWeb, :controller

  alias Islands.Client.State
  alias Islands.{Engine, Game, Player}
  alias Phoenix.Token

  @salt Application.get_env(:islands_vue_client, :salt)

  plug :require_player when action != :index

  def index(conn, _params) do
    games_overview = Engine.games_overview()
    render conn, "index.html", overviews: games_overview
  end

  def new(conn, _params) do
    game_name = Game.haiku_name()
    %Player{name: name, gender: gender} = get_session(conn, :player)

    conn
    # Allows next player to join game from other tabs of same browser...
    |> delete_session(:player)
    |> show(State.new(game_name, :player1, name, gender, basic: true))
  end

  def join(conn, %{"id" => game_name} = _params) do
    %Player{name: name, gender: gender} = get_session(conn, :player)

    conn
    # Allows next player to join game from other tabs of same browser...
    |> delete_session(:player)
    |> show(State.new(game_name, :player2, name, gender, basic: true))
  end

  ## Private functions

  defp show(
         conn,
         %State{game_name: game_name, player_id: player_id} = player_state
       ) do
    conn
    |> assign(:player_id, player_id)
    |> assign(:game_url, Routes.game_url(conn, :join, game_name))
    |> assign(:game_name, game_name)
    |> assign(:auth_token, Token.sign(conn, @salt, player_state))
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
end
