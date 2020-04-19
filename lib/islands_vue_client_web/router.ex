defmodule Islands.Vue.ClientWeb.Router do
  use Islands.Vue.ClientWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Islands.Vue.ClientWeb do
    # Use the default browser stack
    pipe_through :browser

    get "/", GameController, :new
    get "/games/new", GameController, :new
    get "/games/:id", GameController, :join
    # resources "/games", GameController, only: [:new, :create, :show]

    get "/sessions/new", SessionController, :new
    post "/sessions", SessionController, :create
    # resources "/sessions", SessionController, only: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Islands.Vue.ClientWeb do
  #   pipe_through :api
  # end
end
