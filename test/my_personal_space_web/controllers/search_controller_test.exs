defmodule MyPersonalSpaceWeb.SearchControllerTest do
  use MyPersonalSpace.ConnCase

  import MyPersonalSpace.Fixtures.{AuthorFixtures, QuoteFixtures}

  describe "GET /search" do
    test "returns 200 and search results for valid query", %{conn: conn} do
      author = author_fixture(name: "Searchable Author")
      _quote = quote_fixture(author_id: author.id, text: "Searchable quote text")

      conn = get(conn, "/search", query: "Searchable")
      response = html_response(conn, 200)

      # Verify search results page renders
      assert response =~ "Results for"
      assert response =~ "Searchable"
    end

    test "returns 200 with empty results for non-matching query", %{conn: conn} do
      author = author_fixture()
      _quote = quote_fixture(author_id: author.id)

      conn = get(conn, "/search", query: "xyznonexistent")
      response = html_response(conn, 200)

      assert response =~ "Results for"
      assert response =~ "No results"
    end

    test "returns 404 when no query is provided", %{conn: conn} do
      conn = get(conn, "/search")
      assert html_response(conn, 404)
    end

    test "returns 404 when query is empty string", %{conn: conn} do
      conn = get(conn, "/search", query: "")
      assert html_response(conn, 404)
    end

    test "returns 200 and search results for query with single quote", %{conn: conn} do
      author = author_fixture(name: "O'Connor")
      _quote = quote_fixture(author_id: author.id, text: "It's a wonderful day")

      conn = get(conn, "/search", query: "O'Connor")
      response = html_response(conn, 200)

      assert response =~ "Results for"
      # HTML entities are escaped, so we check for both forms
      assert response =~ "O&#39;Connor" or response =~ "O'Connor"
    end
  end
end
