defmodule Picoquotes.Resolver do
  alias Picoquotes.Contexts.{AuthorContext, QuoteContext}

  def resolve_quotes(_parent, _args, _resolution) do
    {:ok, QuoteContext.list_quotes()}
  end

  def resolve_author_by_slug(_parent, %{slug: slug} = _args, _resolution) do
    {:ok, AuthorContext.get_author_by_slug(slug)}
  end

  def resolve_author_quotes(author, _args, _resolution) do
    author_quotes =
      author
      |> QuoteContext.list_quotes_by_author()
      |> Enum.map(&Map.put(&1, :author, author))

    {:ok, author_quotes}
  end
end
