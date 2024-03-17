defmodule MyPersonalSpace.Search do
  alias MyPersonalSpace.Repo
  alias MyPersonalSpace.Search.AuthorIndex
  alias MyPersonalSpace.Search.QuoteIndex

  import Ecto.Query

  def search_authors(term) do
    query =
      from(a in AuthorIndex,
        select: a,
        where: fragment("authors_index MATCH ?", ^term),
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
        where: fragment("quotes_index MATCH ?", ^term),
        order_by: :rank
      )

    Repo.all(query)
  end
end
