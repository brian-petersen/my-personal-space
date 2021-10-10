defmodule PicoquotesWeb.Router do
  use Phoenix.Router

  alias Picoquotes.Repo
  alias PicoquotesWeb.AuthorsController
  alias PicoquotesWeb.Plugs.Authenticate
  alias PicoquotesWeb.QuotesController
  alias PicoquotesWeb.SessionsController
  alias PicoquotesWeb.Telemetry

  import Phoenix.Controller
  import Phoenix.LiveDashboard.Router
  import Plug.Conn

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    get "/", QuotesController, :index
    get "/author/:slug", AuthorsController, :show
    resources "/authors", AuthorsController, only: [:create, :new]
    resources "/quotes", QuotesController, except: [:index, :show]
    resources "/sessions", SessionsController, only: [:create, :delete, :new], singleton: true
  end

  scope "/" do
    pipe_through [:browser, :authenticated]

    live_dashboard "/dashboard", ecto_repos: [Repo], metrics: Telemetry
  end
end
