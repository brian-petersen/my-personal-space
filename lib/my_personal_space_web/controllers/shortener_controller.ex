defmodule MyPersonalSpaceWeb.ShortenerController do
  use Phoenix.Controller

  alias MyPersonalSpace.Shortener
  # alias MyPersonalSpace.Contexts.{AuthorContext, QuoteContext}
  # alias MyPersonalSpace.Models.Author
  # alias MyPersonalSpaceWeb.ErrorView
  alias MyPersonalSpaceWeb.Plugs.Authenticate
  # alias MyPersonalSpaceWeb.Router.Helpers, as: Routes

  plug Authenticate when action not in [:show]

  # def new(conn, _params) do
  #   changeset = Author.build(%{})
  #
  #   render(conn, "new.html", changeset: changeset)
  # end
  #
  # def create(conn, %{"author" => author_params}) do
  #   case AuthorContext.create_author(author_params) do
  #     {:ok, _} ->
  #       conn
  #       |> put_flash(:info, "Successfully created author.")
  #       |> redirect(to: Routes.quotes_quotes_path(conn, :index))
  #
  #     {:error, changeset} ->
  #       conn
  #       |> put_flash(:error, "Failed to create author.")
  #       |> render("new.html", changeset: changeset)
  #   end
  # end

  def index(conn, _params) do
    send_resp(conn, 404, Shortener.get_links() |> inspect())
  end

  def show(conn, %{"slug" => slug} = _params) do
    case Shortener.get_link(slug) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(ErrorView)
        |> render("404.html")

      link ->
        redirect(conn, external: link)
    end
  end

  # defp group_authors(authors) do
  #   init_letter = fn grouped_authors, letter ->
  #     if Map.has_key?(grouped_authors, letter) do
  #       grouped_authors
  #     else
  #       Map.put(grouped_authors, letter, [])
  #     end
  #   end
  #
  #   Enum.reduce(authors, %{}, fn %Author{name: name} = author, grouped_authors ->
  #     letter = name |> String.first() |> String.upcase()
  #
  #     grouped_authors
  #     |> init_letter.(letter)
  #     |> Map.update!(letter, &[author | &1])
  #   end)
  # end
  #
  # defp page_title(%{name: name} = _author) do
  #   "Quotes by #{name}"
  # end
end
