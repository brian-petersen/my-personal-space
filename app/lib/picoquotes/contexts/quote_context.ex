defmodule Picoquotes.Contexts.QuoteContext do
  import Ecto.Query

  alias Picoquotes.Models.{Author, Quote}
  alias Picoquotes.Repo

  def create_quote(params) do
    params
    |> Quote.build()
    |> Repo.insert()
  end

  @doc """
  Returns all quotes sorted by inserted at with their author preloaded.
  """
  def list_quotes() do
    query =
      from(Quote,
        preload: [:author],
        order_by: [desc: :inserted_at]
      )

    Repo.all(query)
  end

  @doc """
  Returns all quotes sorted by inserted at for an author.
  """
  def list_quotes_by_author(%Author{id: author_id}) do
    list_quotes_by_author(author_id)
  end

  @doc """
  Returns all quotes sorted by inserted at for an author.
  """
  def list_quotes_by_author(author_id) do
    query =
      from(q in Quote,
        where: q.author_id == ^author_id,
        order_by: [desc: :inserted_at]
      )

    Repo.all(query)
  end
end
