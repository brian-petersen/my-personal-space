defmodule PicoquotesWeb.AuthorsController do
  use Phoenix.Controller

  alias Picoquotes.Contexts.{AuthorContext, QuoteContext}
  alias PicoquotesWeb.ErrorView

  def show(conn, %{"slug" => slug} = _params) do
    with author when not is_nil(author) <- AuthorContext.get_author_by_slug(slug),
         quotes <- QuoteContext.list_quotes_by_author(author) do
      render(conn, "show.html", page_title: page_title(author), author: author, quotes: quotes)
    else
      _ ->
        conn
        |> put_status(:not_found)
        |> put_view(ErrorView)
        |> render("404.html")
    end
  end

  defp page_title(%{name: name} = _author) do
    "Quotes by #{name}"
  end
end
