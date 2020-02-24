defmodule Picoquotes.Models.Quote do
  use Ecto.Schema

  alias Picoquotes.Models.Author

  schema "quotes" do
    field(:text, :string)
    belongs_to(:author, Author)

    timestamps()
  end
end
