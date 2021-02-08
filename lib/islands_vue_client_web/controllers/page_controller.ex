defmodule Islands.Vue.ClientWeb.PageController do
  use Islands.Vue.ClientWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
