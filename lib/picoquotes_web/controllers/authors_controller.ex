defmodule PicoquotesWeb.AuthorsController do
  use Phoenix.Controller

  alias Picoquotes.Contexts.{AuthorContext, QuoteContext}
  alias Picoquotes.Models.Author
  alias PicoquotesWeb.ErrorView
  alias PicoquotesWeb.Plugs.Authenticate
  alias PicoquotesWeb.Router.Helpers, as: Routes

  plug Authenticate when action not in [:show]

  def new(conn, _params) do
    changeset = Author.build(%{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"author" => author_params}) do
    case AuthorContext.create_author(author_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully created author.")
        |> redirect(to: Routes.quotes_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Failed to create author.")
        |> render("new.html", changeset: changeset)
    end
  end

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
