defmodule MyPersonalSpaceWeb.QuotesControllerAuthTest do
  use MyPersonalSpace.ConnCase

  import MyPersonalSpace.Fixtures.{AuthorFixtures, QuoteFixtures, UserFixtures}

  describe "GET /quotes/new (new quote form)" do
    test "returns 401 when not authenticated", %{conn: conn} do
      conn = get(conn, "/quotes/new")
      assert response(conn, 401) =~ "Not authorized"
    end

    test "returns 200 when authenticated", %{conn: conn} do
      conn = authenticated_conn(conn)
      conn = get(conn, "/quotes/new")
      assert html_response(conn, 200) =~ "Quote"
      assert html_response(conn, 200) =~ "Author"
    end
  end

  describe "POST /quotes (create quote)" do
    test "returns 401 when not authenticated", %{conn: conn} do
      author = author_fixture()

      conn =
        post(conn, "/quotes", %{
          "quote" => %{
            "text" => "New quote text",
            "author_id" => author.id
          }
        })

      assert response(conn, 401) =~ "Not authorized"
    end

    test "creates quote and redirects when authenticated", %{conn: conn} do
      author = author_fixture()
      conn = authenticated_conn(conn)

      conn =
        post(conn, "/quotes", %{
          "quote" => %{
            "text" => "New quote text",
            "author_id" => author.id
          }
        })

      assert redirected_to(conn, 302) =~ "/quotes/"
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Successfully created"
    end

    test "renders errors with invalid data when authenticated", %{conn: conn} do
      conn = authenticated_conn(conn)

      conn =
        post(conn, "/quotes", %{
          "quote" => %{
            "text" => "",
            "author_id" => nil
          }
        })

      assert html_response(conn, 200) =~ "Quote"
      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~ "Failed to create"
    end
  end

  describe "GET /quotes/:id/edit (edit quote form)" do
    test "returns 401 when not authenticated", %{conn: conn} do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)

      conn = get(conn, "/quotes/#{quote.id}/edit")
      assert response(conn, 401) =~ "Not authorized"
    end

    test "returns 200 when authenticated", %{conn: conn} do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)
      conn = authenticated_conn(conn)

      conn = get(conn, "/quotes/#{quote.id}/edit")
      assert html_response(conn, 200) =~ "Quote"
      assert html_response(conn, 200) =~ "Submit"
    end

    test "returns 404 for non-existent quote when authenticated", %{conn: conn} do
      conn = authenticated_conn(conn)
      conn = get(conn, "/quotes/99999/edit")
      assert html_response(conn, 404)
    end
  end

  describe "PUT /quotes/:id (update quote)" do
    test "returns 401 when not authenticated", %{conn: conn} do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)

      conn =
        put(conn, "/quotes/#{quote.id}", %{
          "quote" => %{"text" => "Updated text"}
        })

      assert response(conn, 401) =~ "Not authorized"
    end

    test "updates quote and redirects when authenticated", %{conn: conn} do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)
      conn = authenticated_conn(conn)

      conn =
        put(conn, "/quotes/#{quote.id}", %{
          "quote" => %{"text" => "Updated text"}
        })

      assert redirected_to(conn, 302) =~ "/quotes/"
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Successfully edited"
    end

    test "renders errors with invalid data when authenticated", %{conn: conn} do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)
      conn = authenticated_conn(conn)

      conn =
        put(conn, "/quotes/#{quote.id}", %{
          "quote" => %{"text" => ""}
        })

      assert html_response(conn, 200) =~ "Quote"
      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~ "Failed to edit"
    end
  end

  describe "DELETE /quotes/:id (delete quote)" do
    test "returns 401 when not authenticated", %{conn: conn} do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)

      conn = delete(conn, "/quotes/#{quote.id}")
      assert response(conn, 401) =~ "Not authorized"
    end

    test "deletes quote and redirects when authenticated", %{conn: conn} do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)
      conn = authenticated_conn(conn)

      conn = delete(conn, "/quotes/#{quote.id}")

      assert redirected_to(conn, 302) == "/quotes"
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Successfully deleted"
    end
  end
end
