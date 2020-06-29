defmodule PicoquotesWeb.QuotesController do
  use Phoenix.Controller

  alias Picoquotes.Contexts.{AuthorContext, QuoteContext}
  alias Picoquotes.Models.Quote
  alias PicoquotesWeb.Plugs.Authenticate
  alias PicoquotesWeb.Router.Helpers, as: Routes

  plug Authenticate when action not in [:index]

  def index(conn, _params) do
    render(conn, "index.html", quotes: QuoteContext.list_quotes())
  end

  def new(conn, _params) do
    changeset = Quote.build(%{})
    authors = get_authors()

    render(conn, "new.html", changeset: changeset, authors: authors)
  end

  def create(conn, %{"quote" => quote_params}) do
    case QuoteContext.create_quote(quote_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully created quote.")
        |> redirect(to: Routes.quotes_path(conn, :index))

      {:error, changeset} ->
        authors = get_authors()

        conn
        |> put_flash(:error, "Failed to create quote.")
        |> render("new.html", changeset: changeset, authors: authors)
    end
  end

  def delete(conn, %{"id" => id}) do
    case QuoteContext.delete_quote_by_id(id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully deleted quote.")
        |> redirect(to: Routes.quotes_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Failed deleting quote.")
        |> redirect(to: Routes.quotes_path(conn, :index))
    end
  end

  defp get_authors do
    AuthorContext.list_authors_sorted()
    |> Enum.map(fn author ->
      {author.name, author.id}
    end)
  end
end
