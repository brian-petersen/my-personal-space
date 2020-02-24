defmodule Picoquotes.Models.Author do
  use Ecto.Schema

  alias Picoquotes.Models.Quote

  schema "authors" do
    field(:name, :string)
    field(:slug, :string)
    has_many(:quotes, Quote)

    timestamps()
  end
end
