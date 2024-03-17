defmodule MyPersonalSpace.Search.AuthorIndex do
  use Ecto.Schema

  @primary_key {:author_id, :id, source: :rowid}
  schema "authors_index" do
    field(:name, :string)
    field(:slug, :string)
  end
end
