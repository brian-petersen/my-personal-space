defmodule Picoquotes.Models.Quote do
  use Ecto.Schema

  alias Picoquotes.Models.Author

  import Ecto.Changeset

  schema "quotes" do
    field(:text, :string)
    belongs_to(:author, Author)

    timestamps()
  end

  def build(params) do
    %__MODULE__{}
    |> cast(params, [:text, :author_id])
    |> validate_required([:text])
    |> assoc_constraint(:author)
  end
end
