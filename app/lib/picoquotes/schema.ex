defmodule Picoquotes.Schema do
  use Absinthe.Schema

  alias Picoquotes.Resolver

  @desc "An author of a quote"
  object :author do
    field(:name, :string)
    field(:slug, :string)

    field :quotes, list_of(:quote) do
      resolve(&Resolver.resolve_author_quotes/3)
    end
  end

  @desc "An inspiring quote"
  object :quote do
    field(:text, :string)
    field(:author, :author)
  end

  query do
    @desc "All recorded quotes"
    field :quotes, list_of(:quote) do
      resolve(&Resolver.resolve_quotes/3)
    end

    @desc "Get an author by their slug"
    field :author_by_slug, :author do
      arg(:slug, non_null(:string))

      resolve(&Resolver.resolve_author_by_slug/3)
    end
  end
end
