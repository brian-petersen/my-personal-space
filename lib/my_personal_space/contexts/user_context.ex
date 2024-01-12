defmodule MyPersonalSpace.Contexts.UserContext do
  import Ecto.Query

  alias MyPersonalSpace.Models.User
  alias MyPersonalSpace.Repo

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
