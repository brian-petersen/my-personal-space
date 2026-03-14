defmodule MyPersonalSpaceWeb.AuthorsControllerTest do
  use MyPersonalSpace.ConnCase

  import MyPersonalSpace.Fixtures.{AuthorFixtures, QuoteFixtures, UserFixtures}

  describe "GET /quotes/authors (index)" do
    test "returns 200 status and renders authors list", %{conn: conn} do
      # Create some test authors
      author_fixture(name: "Alice")
      author_fixture(name: "Bob")
      author_fixture(name: "Charlie")

      conn = get(conn, "/quotes/authors")
      response = html_response(conn, 200)

      # Verify page renders correctly
      assert response =~ "Authors"
      assert response =~ "Alice"
      assert response =~ "Bob"
    end

    test "renders empty list when no authors exist", %{conn: conn} do
      conn = get(conn, "/quotes/authors")
      assert html_response(conn, 200) =~ "Authors"
    end
  end

  describe "GET /quotes/authors/:slug (show)" do
    test "returns 200 status for valid author slug", %{conn: conn} do
      author = author_fixture(name: "Test Author")
      quote = quote_fixture(author_id: author.id)

      conn = get(conn, "/quotes/authors/#{author.slug}")
      response = html_response(conn, 200)

      # Verify author name and quotes are displayed
      assert response =~ author.name
      assert response =~ quote.text
    end

    test "returns 404 status for invalid author slug", %{conn: conn} do
      conn = get(conn, "/quotes/authors/non-existent-slug")
      assert html_response(conn, 404)
    end

    test "displays page title with author name", %{conn: conn} do
      author = author_fixture(name: "Jane Doe")

      conn = get(conn, "/quotes/authors/#{author.slug}")
      response = html_response(conn, 200)

      assert response =~ "Quotes by Jane Doe"
    end
  end

  describe "GET /quotes/authors/new (new author form)" do
    test "returns 401 when not authenticated", %{conn: conn} do
      conn = get(conn, "/quotes/authors/new")
      assert response(conn, 401) =~ "Not authorized"
    end

    test "returns 200 when authenticated", %{conn: conn} do
      conn = authenticated_conn(conn)
      conn = get(conn, "/quotes/authors/new")
      assert html_response(conn, 200) =~ "Author"
      assert html_response(conn, 200) =~ "Create"
    end
  end

  describe "POST /quotes/authors (create author)" do
    test "returns 401 when not authenticated", %{conn: conn} do
      conn =
        post(conn, "/quotes/authors", %{
          "author" => %{"name" => "New Author"}
        })

      assert response(conn, 401) =~ "Not authorized"
    end

    test "creates author and redirects when authenticated", %{conn: conn} do
      conn = authenticated_conn(conn)

      conn =
        post(conn, "/quotes/authors", %{
          "author" => %{"name" => "New Author"}
        })

      assert redirected_to(conn, 302) == "/quotes"
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Successfully created"
    end

    test "renders errors with invalid data when authenticated", %{conn: conn} do
      conn = authenticated_conn(conn)

      conn =
        post(conn, "/quotes/authors", %{
          "author" => %{"name" => ""}
        })

      assert html_response(conn, 200) =~ "Author"
      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~ "Failed to create"
    end
  end
end
