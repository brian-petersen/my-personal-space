defmodule Picoquotes.Contexts.AuthorContext do
  import Ecto.Query

  alias Picoquotes.Models.Author
  alias Picoquotes.Repo

  def create_author(params) do
    params
    |> Author.build()
    |> Repo.insert()
  end

  def get_author_by_slug(slug) do
    query =
      from(u in Author,
        where: u.slug == ^slug
      )

    Repo.one(query)
  end
end
