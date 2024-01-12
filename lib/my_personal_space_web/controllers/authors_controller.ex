defmodule MyPersonalSpaceWeb.AuthorsController do
  use Phoenix.Controller

  alias MyPersonalSpace.Contexts.{AuthorContext, QuoteContext}
  alias MyPersonalSpace.Models.Author
  alias MyPersonalSpaceWeb.ErrorView
  alias MyPersonalSpaceWeb.Plugs.Authenticate
  alias MyPersonalSpaceWeb.Router.Helpers, as: Routes

  plug Authenticate when action not in [:index, :show]

  def new(conn, _params) do
    changeset = Author.build(%{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"author" => author_params}) do
    case AuthorContext.create_author(author_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully created author.")
        |> redirect(to: Routes.picoquotes_quotes_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Failed to create author.")
        |> render("new.html", changeset: changeset)
    end
  end

  def index(conn, _params) do
    grouped_authors = AuthorContext.list_authors_sorted() |> group_authors()

    render(conn, "index.html", grouped_authors: grouped_authors)
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

  defp group_authors(authors) do
    init_letter = fn grouped_authors, letter ->
      if Map.has_key?(grouped_authors, letter) do
        grouped_authors
      else
        Map.put(grouped_authors, letter, [])
      end
    end

    Enum.reduce(authors, %{}, fn %Author{name: name} = author, grouped_authors ->
      letter = name |> String.first() |> String.upcase()

      grouped_authors
      |> init_letter.(letter)
      |> Map.update!(letter, &[author | &1])
    end)
  end

  defp page_title(%{name: name} = _author) do
    "Quotes by #{name}"
  end
end
