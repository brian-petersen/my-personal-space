defmodule MyPersonalSpace.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyPersonalSpace.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{

      })
      |> MyPersonalSpace.Blog.create_post()

    post
  end

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{

      })
      |> MyPersonalSpace.Blog.create_category()

    category
  end

  @doc """
  Generate a post_category.
  """
  def post_category_fixture(attrs \\ %{}) do
    {:ok, post_category} =
      attrs
      |> Enum.into(%{

      })
      |> MyPersonalSpace.Blog.create_post_category()

    post_category
  end
end
