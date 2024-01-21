defmodule MyPersonalSpace.BlogTest do
  use MyPersonalSpace.DataCase

  alias MyPersonalSpace.Blog

  describe "posts" do
    alias MyPersonalSpace.Blog.Post

    import MyPersonalSpace.BlogFixtures

    @invalid_attrs %{}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{}

      assert {:ok, %Post{} = post} = Blog.create_post(valid_attrs)
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{}

      assert {:ok, %Post{} = post} = Blog.update_post(post, update_attrs)
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end

  describe "categories" do
    alias MyPersonalSpace.Blog.Category

    import MyPersonalSpace.BlogFixtures

    @invalid_attrs %{}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Blog.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Blog.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{}

      assert {:ok, %Category{} = category} = Blog.create_category(valid_attrs)
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{}

      assert {:ok, %Category{} = category} = Blog.update_category(category, update_attrs)
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_category(category, @invalid_attrs)
      assert category == Blog.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Blog.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Blog.change_category(category)
    end
  end

  describe "posts_categories" do
    alias MyPersonalSpace.Blog.PostCategory

    import MyPersonalSpace.BlogFixtures

    @invalid_attrs %{}

    test "list_posts_categories/0 returns all posts_categories" do
      post_category = post_category_fixture()
      assert Blog.list_posts_categories() == [post_category]
    end

    test "get_post_category!/1 returns the post_category with given id" do
      post_category = post_category_fixture()
      assert Blog.get_post_category!(post_category.id) == post_category
    end

    test "create_post_category/1 with valid data creates a post_category" do
      valid_attrs = %{}

      assert {:ok, %PostCategory{} = post_category} = Blog.create_post_category(valid_attrs)
    end

    test "create_post_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post_category(@invalid_attrs)
    end

    test "update_post_category/2 with valid data updates the post_category" do
      post_category = post_category_fixture()
      update_attrs = %{}

      assert {:ok, %PostCategory{} = post_category} = Blog.update_post_category(post_category, update_attrs)
    end

    test "update_post_category/2 with invalid data returns error changeset" do
      post_category = post_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post_category(post_category, @invalid_attrs)
      assert post_category == Blog.get_post_category!(post_category.id)
    end

    test "delete_post_category/1 deletes the post_category" do
      post_category = post_category_fixture()
      assert {:ok, %PostCategory{}} = Blog.delete_post_category(post_category)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post_category!(post_category.id) end
    end

    test "change_post_category/1 returns a post_category changeset" do
      post_category = post_category_fixture()
      assert %Ecto.Changeset{} = Blog.change_post_category(post_category)
    end
  end
end
