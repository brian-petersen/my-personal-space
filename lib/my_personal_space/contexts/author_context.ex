defmodule MyPersonalSpace.Contexts.AuthorContext do
  import Ecto.Query

  alias MyPersonalSpace.Models.Author
  alias MyPersonalSpace.Repo

  def create_author(params) do
    params
    |> Author.build()
    |> Repo.insert()
  end

  def default_author_id() do
    query =
      from(u in Author,
        where: u.slug == "anonymous"
      )

    query
    |> Repo.one()
    |> case do
      %{id: id} -> id
      nil -> nil
    end
  end

  def get_author_by_slug(slug) do
    query =
      from(u in Author,
        where: u.slug == ^slug
      )

    Repo.one(query)
  end

  def list_authors_sorted do
    query =
      from(a in Author,
        order_by: a.name
      )

    Repo.all(query)
  end
end
