defmodule MyPersonalSpace.SearchTest do
  use MyPersonalSpace.DataCase

  import MyPersonalSpace.Fixtures.{AuthorFixtures, QuoteFixtures}

  alias MyPersonalSpace.Search

  describe "escape_term/1 regression tests" do
    test "handles search terms with embedded double quotes" do
      author = author_fixture(name: "Test Author")
      _quote = quote_fixture(author_id: author.id, text: "He said foo and then bar")

      # This should not raise an FTS syntax error
      results = Search.search_quotes("foo\"bar")
      assert is_list(results)
    end

    test "handles search terms with multiple embedded double quotes" do
      author = author_fixture(name: "Test Author")
      _quote = quote_fixture(author_id: author.id, text: "It's a test with quotes")

      # This should not raise an FTS syntax error
      results = Search.search_quotes("foo\"bar\"baz")
      assert is_list(results)
    end

    test "handles search terms with double quotes at start and end" do
      author = author_fixture(name: "Test Author")
      _quote = quote_fixture(author_id: author.id, text: "Quoted text here")

      # This should not raise an FTS syntax error
      results = Search.search_quotes("\"quoted\"")
      assert is_list(results)
    end
  end

  describe "search_quotes/1" do
    test "returns matching quotes" do
      author = author_fixture(name: "Test Author")
      _quote = quote_fixture(author_id: author.id, text: "A wonderful quote about life")

      results = Search.search_quotes("wonderful")
      assert length(results) > 0
      assert hd(results).text =~ "wonderful"
    end
  end

  describe "search_authors/1" do
    test "returns matching authors" do
      _author = author_fixture(name: "Unique Author Name")

      results = Search.search_authors("Unique")
      assert length(results) > 0
      assert hd(results).name == "Unique Author Name"
    end
  end
end
