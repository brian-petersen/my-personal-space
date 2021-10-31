defmodule PicoquotesWeb.QuotesController do
  use Phoenix.Controller

  alias Picoquotes.Contexts.{AuthorContext, QuoteContext}
  alias Picoquotes.Models.Quote
  alias PicoquotesWeb.Plugs.Authenticate
  alias PicoquotesWeb.Router.Helpers, as: Routes

  plug Authenticate when action not in [:index]

  def create(conn, %{"quote" => quote_params}) do
    case QuoteContext.create_quote(quote_params) do
      {:ok, %{permalink: permalink}} ->
        conn
        |> put_flash(:info, "Successfully created quote.")
        |> redirect(to: Routes.quotes_path(conn, :index) <> "##{permalink}")

      {:error, changeset} ->
        authors = get_authors()

        conn
        |> put_flash(:error, "Failed to create quote.")
        |> render("new.html", authors: authors, changeset: changeset)
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

  def edit(conn, %{"id" => id}) do
    case QuoteContext.get_quote(id) do
      {:ok, quote} ->
        changeset = Quote.build(quote, %{})
        authors = get_authors()
        render(conn, "edit.html", authors: authors, changeset: changeset, quote_id: quote.id)

      {:error, _} ->
        send_resp(conn, 404, "Not found")
    end
  end

  def index(conn, _params) do
    render(conn, "index.html", quotes: QuoteContext.list_quotes())
  end

  def new(conn, _params) do
    changeset = Quote.build(%{})
    authors = get_authors()

    render(conn, "new.html", authors: authors, changeset: changeset)
  end

  def show(conn, %{"id" => permalink}) do
    case QuoteContext.get_quote_by_permalink(permalink) do
      {:ok, %{permalink: permalink}} ->
        redirect(conn, to: Routes.quotes_path(conn, :index) <> "##{permalink}")

      {:error, _} ->
        send_resp(conn, 404, "Not found")
    end
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    case QuoteContext.update_quote(id, quote_params) do
      {:ok, %{permalink: permalink}} ->
        conn
        |> put_flash(:info, "Successfully edited quote.")
        |> redirect(to: Routes.quotes_path(conn, :index) <> "##{permalink}")

      {:error, changeset} ->
        authors = get_authors()

        conn
        |> put_flash(:error, "Failed to edit quote.")
        |> render("edit.html", authors: authors, changeset: changeset, quote_id: id)
    end
  end

  defp get_authors do
    AuthorContext.list_authors_sorted()
    |> Enum.map(fn author ->
      {author.name, author.id}
    end)
  end
end
