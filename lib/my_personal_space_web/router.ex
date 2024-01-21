defmodule MyPersonalSpaceWeb.Router do
  use Phoenix.Router

  alias MyPersonalSpace.Repo
  alias MyPersonalSpaceWeb.AuthorsController
  alias MyPersonalSpaceWeb.PagesController
  alias MyPersonalSpaceWeb.Plugs.Authenticate
  alias MyPersonalSpaceWeb.QuotesController
  alias MyPersonalSpaceWeb.SessionsController
  alias MyPersonalSpaceWeb.SqlDashboard
  alias MyPersonalSpaceWeb.Telemetry

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

    get "/quotes.csv", QuotesController, :index_csv
    scope "/quotes", as: :quotes do
      get "/", QuotesController, :index
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
