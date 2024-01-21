defmodule MyPersonalSpace.Blog.PostCategory do
  use Ecto.Schema

  alias MyPersonalSpace.Blog.Category
  alias MyPersonalSpace.Blog.Post

  import Ecto.Changeset

  @primary_key false

  schema "posts_categories" do
    belongs_to :category, Category, primary_key: true
    belongs_to :post, Post, primary_key: true

    timestamps()
  end

  def changeset(post_category, attrs) do
    post_category
    |> cast(attrs, [:category_id, :post_id])
    |> validate_required([:category_id, :post_id])
  end
end
