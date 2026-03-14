defmodule MyPersonalSpace.Fixtures.QuoteFixtures do
  @moduledoc """
  This module defines test helpers for creating
  quote entities.
  """

  alias MyPersonalSpace.Contexts.QuoteContext
  alias MyPersonalSpace.Fixtures.AuthorFixtures
  alias MyPersonalSpace.Repo

  def unique_quote_text, do: "Test quote #{System.unique_integer([:positive])}"

  defp get_author_id(attrs) do
    attrs = Map.new(attrs)
    Map.get(attrs, :author_id) || AuthorFixtures.author_fixture().id
  end

  defp preload_author(quote) do
    Repo.preload(quote, :author)
  end

  def quote_fixture(attrs \\ %{}) do
    author_id = get_author_id(attrs)
    attrs = Map.new(attrs)

    {:ok, quote} =
      attrs
      |> Enum.into(%{
        text: unique_quote_text(),
        author_id: author_id
      })
      |> QuoteContext.create_quote()

    preload_author(quote)
  end

  def quote_with_source_fixture(attrs \\ %{}) do
    author_id = get_author_id(attrs)
    attrs = Map.new(attrs)

    {:ok, quote} =
      attrs
      |> Enum.into(%{
        text: unique_quote_text(),
        author_id: author_id,
        source: "https://example.com/source"
      })
      |> QuoteContext.create_quote()

    preload_author(quote)
  end

  def quote_with_rendered_text_fixture(attrs \\ %{}) do
    author_id = get_author_id(attrs)
    attrs = Map.new(attrs)

    {:ok, quote} =
      attrs
      |> Enum.into(%{
        text: "# Heading\n\nThis is **bold** text",
        author_id: author_id
      })
      |> QuoteContext.create_quote()

    preload_author(quote)
  end
end
