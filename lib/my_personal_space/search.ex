defmodule MyPersonalSpace.Search do
  alias MyPersonalSpace.Repo
  alias MyPersonalSpace.Search.AuthorIndex
  alias MyPersonalSpace.Search.QuoteIndex

  import Ecto.Query

  def search_authors(term) do
    query =
      from(a in AuthorIndex,
        select: a,
        where: fragment("authors_index MATCH ?", ^escape_term(term)),
        order_by: :rank
      )

    Repo.all(query)
  end

  def search_quotes(term) do
    query =
      from(a in QuoteIndex,
        select: %{
          text: fragment("snippet(quotes_index, 0, '\"', '\"', '...', 15)"),
          permalink: a.permalink
        },
        where: fragment("quotes_index MATCH ?", ^escape_term(term)),
        order_by: :rank
      )

    Repo.all(query)
  end

  defp escape_term(term) do
    term
    |> String.replace("\"", "\"\"")
    |> then(&"\"#{&1}\"")
  end
end
