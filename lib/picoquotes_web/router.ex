defmodule PicoquotesWeb.Router do
  use Phoenix.Router

  alias PicoquotesWeb.{AuthorsController, SessionsController, QuotesController}

  import Phoenix.Controller
  import Plug.Conn

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

  scope "/" do
    pipe_through :browser

    get "/", QuotesController, :index

    get "/author/:slug", AuthorsController, :show

    resources "/sessions", SessionsController, only: [:new, :create, :delete], singleton: true
  end
end
