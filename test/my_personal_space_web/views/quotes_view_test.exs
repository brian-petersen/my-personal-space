defmodule MyPersonalSpaceWeb.QuotesHTMLTest do
  use MyPersonalSpace.ConnCase

  import MyPersonalSpace.Fixtures.{AuthorFixtures, QuoteFixtures, UserFixtures}

  # Helper to build a conn with session support
  defp build_conn_with_session do
    Phoenix.ConnTest.build_conn()
    |> Phoenix.ConnTest.init_test_session(%{})
  end

  describe "quote card rendering" do
    test "renders markdown as HTML when text_rendered is present" do
      author = author_fixture()
      quote = quote_with_rendered_text_fixture(author_id: author.id)

      conn = build_conn_with_session()

      html =
        MyPersonalSpaceWeb.QuotesHTML.card(%{
          conn: conn,
          quote: quote,
          show_author: true
        })
        |> Phoenix.HTML.Safe.to_iodata()
        |> IO.iodata_to_binary()

      # Verify markdown is rendered as HTML
      assert html =~ "<h1>Heading</h1>"
      assert html =~ "<strong>bold</strong>"
    end

    test "renders plain text when text_rendered is nil" do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id, text: "Plain text quote")

      # Manually set text_rendered to nil
      quote = %{quote | text_rendered: nil}

      conn = build_conn_with_session()

      html =
        MyPersonalSpaceWeb.QuotesHTML.card(%{
          conn: conn,
          quote: quote,
          show_author: true
        })
        |> Phoenix.HTML.Safe.to_iodata()
        |> IO.iodata_to_binary()

      # Verify plain text is displayed in a paragraph
      assert html =~ "Plain text quote"
    end
  end

  describe "source link rendering" do
    test "renders source as clickable link when source is a valid URL" do
      author = author_fixture()
      quote = quote_with_source_fixture(author_id: author.id)

      conn = build_conn_with_session()

      html =
        MyPersonalSpaceWeb.QuotesHTML.card(%{
          conn: conn,
          quote: quote,
          show_author: true
        })
        |> Phoenix.HTML.Safe.to_iodata()
        |> IO.iodata_to_binary()

      # Verify source is rendered as a link
      assert html =~ "href=\"https://example.com/source\""
    end

    test "renders source as plain text when source is not a URL" do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id, source: "A Book Title")

      conn = build_conn_with_session()

      html =
        MyPersonalSpaceWeb.QuotesHTML.card(%{
          conn: conn,
          quote: quote,
          show_author: true
        })
        |> Phoenix.HTML.Safe.to_iodata()
        |> IO.iodata_to_binary()

      # Verify source is displayed as plain text
      assert html =~ "A Book Title"
      # Should not be a link
      refute html =~ "href=\"http"
    end
  end

  describe "author link visibility" do
    test "shows author link when show_author is true" do
      author = author_fixture(name: "John Doe")
      quote = quote_fixture(author_id: author.id)

      conn = build_conn_with_session()

      html =
        MyPersonalSpaceWeb.QuotesHTML.card(%{
          conn: conn,
          quote: quote,
          show_author: true
        })
        |> Phoenix.HTML.Safe.to_iodata()
        |> IO.iodata_to_binary()

      # Verify author link is present
      assert html =~ author.name
      assert html =~ "/quotes/authors/#{author.slug}"
    end
  end

  describe "action buttons visibility" do
    test "hides edit and delete buttons when not authenticated" do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)

      conn = build_conn_with_session()

      html =
        MyPersonalSpaceWeb.QuotesHTML.card(%{
          conn: conn,
          quote: quote,
          show_author: true
        })
        |> Phoenix.HTML.Safe.to_iodata()
        |> IO.iodata_to_binary()

      # Verify edit and delete links are not present
      refute html =~ "/edit"
      refute html =~ "data-confirm=\"Really delete?\""
    end

    test "shows edit and delete buttons when authenticated" do
      author = author_fixture()
      quote = quote_fixture(author_id: author.id)

      conn =
        build_conn_with_session()
        |> authenticated_conn()

      html =
        MyPersonalSpaceWeb.QuotesHTML.card(%{
          conn: conn,
          quote: quote,
          show_author: true
        })
        |> Phoenix.HTML.Safe.to_iodata()
        |> IO.iodata_to_binary()

      # Verify edit and delete links are present
      assert html =~ "/edit"
      assert html =~ "Delete"
      assert html =~ "data-confirm=\"Really delete?\""
    end
  end
end
