defmodule MyPersonalSpaceWeb.QuotesController do
  use Phoenix.Controller

  use Phoenix.VerifiedRoutes,
    router: MyPersonalSpaceWeb.Router,
    endpoint: MyPersonalSpaceWeb.Endpoint

  alias MyPersonalSpace.Contexts.AuthorContext
  alias MyPersonalSpace.Contexts.QuoteContext
  alias MyPersonalSpace.Models.Quote
  alias MyPersonalSpaceWeb.ErrorView
  alias MyPersonalSpaceWeb.Plugs.Authenticate

  plug Authenticate when action not in [:index, :index_csv, :show, :random]

  def create(conn, %{"quote" => quote_params}) do
    case QuoteContext.create_quote(quote_params) do
      {:ok, %{permalink: permalink}} ->
        conn
        |> put_flash(:info, "Successfully created quote.")
        |> redirect(to: ~p"/quotes/#{permalink}")

      {:error, changeset} ->
        authors = get_authors()
        default_author_id = AuthorContext.default_author_id()

        conn
        |> put_flash(:error, "Failed to create quote.")
        |> render("new.html",
          authors: authors,
          changeset: changeset,
          default_author_id: default_author_id
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    case QuoteContext.delete_quote_by_id(id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Successfully deleted quote.")
        |> redirect(to: ~p"/quotes")

      {:error, _} ->
        conn
        |> put_flash(:error, "Failed deleting quote.")
        |> redirect(to: ~p"/quotes")
    end
  end

  def edit(conn, %{"id" => id}) do
    case QuoteContext.get_quote(id) do
      {:ok, quote} ->
        changeset = Quote.build(quote, %{})
        authors = get_authors()
        default_author_id = AuthorContext.default_author_id()

        render(conn, "edit.html",
          authors: authors,
          changeset: changeset,
          default_author_id: default_author_id,
          quote_id: quote.id
        )

      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> put_view(ErrorView)
        |> render("404.html")
    end
  end

  def index(conn, _params) do
    render(conn, "index.html", quotes: QuoteContext.list_quotes())
  end

  @spec index_csv(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index_csv(conn, _params) do
    csv_content =
      QuoteContext.list_quotes()
      |> Stream.map(&Quote.to_csv_map/1)
      |> CSV.encode(headers: true)
      |> Enum.to_list()
      |> Enum.join()

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, csv_content)
  end

  def new(conn, _params) do
    changeset = Quote.build(%{})
    authors = get_authors()
    default_author_id = AuthorContext.default_author_id()

    render(conn, "new.html",
      authors: authors,
      changeset: changeset,
      default_author_id: default_author_id
    )
  end

  def show(conn, %{"id" => permalink}) do
    case QuoteContext.get_quote_by_permalink(permalink) do
      {:ok, quote} ->
        render(conn, "show.html", quote: quote)

      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> put_view(ErrorView)
        |> render("404.html")
    end
  end

  def random(conn, _random) do
    %{permalink: permalink} = QuoteContext.get_random_quote()

    redirect(conn, to: ~p"/quotes/#{permalink}")
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    case QuoteContext.update_quote(id, quote_params) do
      {:ok, %{permalink: permalink}} ->
        conn
        |> put_flash(:info, "Successfully edited quote.")
        |> redirect(to: ~p"/quotes/#{permalink}")

      {:error, changeset} ->
        authors = get_authors()
        default_author_id = AuthorContext.default_author_id()

        conn
        |> put_flash(:error, "Failed to edit quote.")
        |> render("edit.html",
          authors: authors,
          changeset: changeset,
          default_author_id: default_author_id,
          quote_id: id
        )
    end
  end

  defp get_authors do
    Enum.map(AuthorContext.list_authors_sorted(), fn author ->
      {author.name, author.id}
    end)
  end
end
