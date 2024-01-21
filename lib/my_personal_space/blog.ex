defmodule MyPersonalSpace.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias MyPersonalSpace.Repo

  alias MyPersonalSpace.Blog.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  alias MyPersonalSpace.Blog.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{data: %Category{}}

  """
  def change_category(%Category{} = category, attrs \\ %{}) do
    Category.changeset(category, attrs)
  end

  alias MyPersonalSpace.Blog.PostCategory

  @doc """
  Returns the list of posts_categories.

  ## Examples

      iex> list_posts_categories()
      [%PostCategory{}, ...]

  """
  def list_posts_categories do
    Repo.all(PostCategory)
  end

  @doc """
  Gets a single post_category.

  Raises `Ecto.NoResultsError` if the Post category does not exist.

  ## Examples

      iex> get_post_category!(123)
      %PostCategory{}

      iex> get_post_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post_category!(id), do: Repo.get!(PostCategory, id)

  @doc """
  Creates a post_category.

  ## Examples

      iex> create_post_category(%{field: value})
      {:ok, %PostCategory{}}

      iex> create_post_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post_category(attrs \\ %{}) do
    %PostCategory{}
    |> PostCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post_category.

  ## Examples

      iex> update_post_category(post_category, %{field: new_value})
      {:ok, %PostCategory{}}

      iex> update_post_category(post_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post_category(%PostCategory{} = post_category, attrs) do
    post_category
    |> PostCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post_category.

  ## Examples

      iex> delete_post_category(post_category)
      {:ok, %PostCategory{}}

      iex> delete_post_category(post_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post_category(%PostCategory{} = post_category) do
    Repo.delete(post_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post_category changes.

  ## Examples

      iex> change_post_category(post_category)
      %Ecto.Changeset{data: %PostCategory{}}

  """
  def change_post_category(%PostCategory{} = post_category, attrs \\ %{}) do
    PostCategory.changeset(post_category, attrs)
  end
end
