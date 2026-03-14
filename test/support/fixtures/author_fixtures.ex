defmodule MyPersonalSpace.Fixtures.AuthorFixtures do
  @moduledoc """
  This module defines test helpers for creating
  author entities.
  """

  alias MyPersonalSpace.Contexts.AuthorContext

  def unique_author_name, do: "Author #{System.unique_integer([:positive])}"

  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        name: unique_author_name()
      })
      |> AuthorContext.create_author()

    author
  end
end
