defmodule Islands.Vue.ClientWeb.GameView do
  use Islands.Vue.ClientWeb, :view

  alias Plug.Conn

  def current_game_url(%Conn{assigns: %{game_name: game_name}} = conn) do
    url(conn) <> game_path(conn, :join, game_name)
  end
end
