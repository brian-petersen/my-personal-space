defmodule MyPersonalSpace.Fixtures.UserFixtures do
  @moduledoc """
  This module defines test helpers for creating
  user entities and managing authentication in tests.
  """

  alias MyPersonalSpace.Contexts.UserContext
  alias MyPersonalSpace.Models.User

  # Username must be 3-15 chars, alphanumeric, hyphens, underscores
  def unique_username, do: "user#{System.unique_integer([:positive])}"
  # Password must be at least 8 chars
  def valid_password, do: "securepass123"

  def user_fixture(attrs \\ %{}) do
    attrs = Map.new(attrs)
    username = Map.get(attrs, :username) || unique_username()
    password = Map.get(attrs, :password) || valid_password()

    # Create user with password hash
    {:ok, user} =
      UserContext.create_user(%{
        username: username,
        password: password
      })

    user
  end

  def authenticated_conn(conn) do
    user = user_fixture()
    authenticate_conn(conn, user)
  end

  def authenticate_conn(conn, %User{id: user_id}) do
    conn
    |> Phoenix.ConnTest.init_test_session(%{})
    |> Plug.Conn.put_session(:user_id, user_id)
    |> Plug.Conn.configure_session(renew: true)
  end
end
