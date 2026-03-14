defmodule MyPersonalSpaceWeb.QuotesControllerTest do
  use MyPersonalSpace.ConnCase

  import MyPersonalSpace.Fixtures.{AuthorFixtures, QuoteFixtures}

  describe "GET /quotes (index)" do
    test "returns 200 status and renders quotes list", %{conn: conn} do
      # Create some test quotes
      quote_fixture()
      quote_fixture()

      conn = get(conn, "/quotes")
      response = html_response(conn, 200)

      # Verify page renders correctly
      assert response =~ "Quotes"
    end

    test "renders empty list when no quotes exist", %{conn: conn} do
      conn = get(conn, "/quotes")
      assert html_response(conn, 200) =~ "Quotes"
    end
  end

  describe "GET /quotes/:permalink (show)" do
    test "returns 200 status for valid quote permalink", %{conn: conn} do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)

      conn = get(conn, "/quotes/#{quote.permalink}")
      response = html_response(conn, 200)

      # Verify quote content is displayed
      assert response =~ quote.text
      assert response =~ author.name
    end

    test "returns 404 status for invalid quote permalink", %{conn: conn} do
      conn = get(conn, "/quotes/invalid-permalink-12345")
      assert html_response(conn, 404)
    end

    test "renders quote with source as clickable link when source is URL", %{conn: conn} do
      author = author_fixture()
      quote = quote_with_source_fixture(author_id: author.id)

      conn = get(conn, "/quotes/#{quote.permalink}")
      response = html_response(conn, 200)

      # Verify source link is rendered
      assert response =~ "href=\"https://example.com/source\""
    end

    test "renders markdown as HTML when text_rendered is present", %{conn: conn} do
      author = author_fixture()
      quote = quote_with_rendered_text_fixture(author_id: author.id)

      conn = get(conn, "/quotes/#{quote.permalink}")
      response = html_response(conn, 200)

      # Verify markdown is rendered as HTML
      assert response =~ "<h1>"
      assert response =~ "<strong>bold</strong>"
    end
  end

  describe "GET /quotes/random" do
    test "redirects to a random quote", %{conn: conn} do
      author = author_fixture()
      _quote = quote_fixture(author_id: author.id)

      conn = get(conn, "/quotes/random")
      assert redirected_to(conn, 302) =~ "/quotes/"
    end

    test "redirects even when only one quote exists", %{conn: conn} do
      author = author_fixture()
      _quote = quote_fixture(author_id: author.id)

      conn = get(conn, "/quotes/random")
      assert redirected_to(conn, 302)
    end
  end

  describe "GET /quotes.csv" do
    test "returns 200 status with CSV content", %{conn: conn} do
      # Use a unique identifier to avoid conflicts with other test data
      unique_id = System.unique_integer([:positive])
      author = author_fixture(name: "CSVAuthor#{unique_id}")
      _quote = quote_fixture(author_id: author.id, text: "CSVTestQuote#{unique_id}")

      conn = get(conn, "/quotes.csv")

      assert response_content_type(conn, :text)
      response = response(conn, 200)

      # Verify CSV structure - headers are alphabetical: author,text,source
      assert response =~ "author,text,source"
      assert response =~ "CSVTestQuote#{unique_id}"
      assert response =~ "CSVAuthor#{unique_id}"

      # Verify CSV line format: author,text,source
      assert response =~ ~r/^CSVAuthor#{unique_id},CSVTestQuote#{unique_id},/m
    end

    test "returns CSV with proper headers", %{conn: conn} do
      conn = get(conn, "/quotes.csv")

      assert response(conn, 200)
      assert response_content_type(conn, :text)

      # Verify CSV has proper headers (alphabetical order)
      response = response(conn, 200)
      assert response =~ "author,text,source"
    end
  end
end
