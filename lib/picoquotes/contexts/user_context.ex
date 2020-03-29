defmodule Picoquotes.Contexts.UserContext do
  import Ecto.Query

  alias Picoquotes.Models.User
  alias Picoquotes.Repo

  def create_user(params) do
    params
    |> User.build()
    |> Repo.insert()
  end

  def get_user_by_username(username) do
    query =
      from(u in User,
        where: u.username == ^username
      )

    Repo.one(query)
  end
end
