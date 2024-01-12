defmodule PicoquotesWeb.Router do
  use Phoenix.Router

  alias Picoquotes.Repo
  alias PicoquotesWeb.AuthorsController
  alias PicoquotesWeb.PagesController
  alias PicoquotesWeb.Plugs.Authenticate
  alias PicoquotesWeb.QuotesController
  alias PicoquotesWeb.SessionsController
  alias PicoquotesWeb.SqlDashboard
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

    get "/", PagesController, :home

    resources "/sessions", SessionsController,
      only: [
        :create,
        :delete,
        :new
      ],
      singleton: true

    scope "/picoquotes", as: :picoquotes do
      get "/", QuotesController, :index
      get "/quotes.csv", QuotesController, :index_csv
      resources "/quotes", QuotesController, except: [:index]

      resources "/authors", AuthorsController,
        param: "slug",
        only: [
          :create,
          :index,
          :new,
          :show
        ]
    end
  end

  scope "/" do
    pipe_through [:browser, :authenticated]

    live_dashboard "/dashboard",
      ecto_repos: [Repo],
      metrics: Telemetry,
      additional_pages: [
        sql_dashboard: SqlDashboard
      ]
  end
end
