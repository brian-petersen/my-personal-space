defmodule MyPersonalSpace.Search.QuoteIndex do
  use Ecto.Schema

  @primary_key {:author_id, :id, source: :rowid}
  schema "quotes_index" do
    field(:text, :string)
    field(:permalink, :string)
  end
end
