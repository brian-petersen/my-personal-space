defmodule Picoquotes.Contexts.AuthorContext do
  import Ecto.Query

  alias Picoquotes.Models.Author
  alias Picoquotes.Repo

  def get_author_by_slug(slug) do
    query =
      from(u in Author,
        where: u.slug == ^slug
      )

    Repo.one(query)
  end
end
