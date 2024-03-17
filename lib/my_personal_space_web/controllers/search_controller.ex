defmodule MyPersonalSpaceWeb.SearchController do
  use Phoenix.Controller

  # alias MyPersonalSpace.Contexts.{AuthorContext, QuoteContext}
  alias MyPersonalSpace.Search
  alias MyPersonalSpaceWeb.ErrorView
  # alias MyPersonalSpaceWeb.ErrorView
  # alias MyPersonalSpaceWeb.Plugs.Authenticate
  # alias MyPersonalSpaceWeb.Router.Helpers, as: Routes

  def search(conn, params) do
    query = Map.get(params, "query", nil)

    if is_nil(query) or query == "" do
      conn
      |> put_view(ErrorView)
      |> put_status(404)
      |> render("404.html")
    else
      authors = Search.search_authors(query)
      quotes = Search.search_quotes(query)

      render(conn, "results.html", query: query, authors: authors, quotes: quotes)
    end
  end
end
