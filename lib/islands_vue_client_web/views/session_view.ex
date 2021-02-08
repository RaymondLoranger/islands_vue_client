defmodule Islands.Vue.ClientWeb.SessionView do
  use Islands.Vue.ClientWeb, :view

  @spec path(Plug.Conn.t(), Path.t()) :: Phoenix.HTML.safe()
  def path(conn, image_path) do
    Routes.static_path(conn, image_path)
  end
end
