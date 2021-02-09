defmodule Picoquotes.Models.Quote do
  use Ecto.Schema

  alias Picoquotes.Models.Author

  import Ecto.Changeset

  schema "quotes" do
    field(:text, :string)
    belongs_to(:author, Author)

    timestamps()
  end

  def build(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [:text, :author_id])
    |> validate_required([:text, :author_id])
    |> assoc_constraint(:author)
  end
end
