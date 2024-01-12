defmodule MyPersonalSpace.Models.Author do
  use Ecto.Schema

  alias MyPersonalSpace.Models.Quote

  import Ecto.Changeset

  schema "authors" do
    field(:name, :string)
    field(:slug, :string)
    has_many(:quotes, Quote)

    timestamps()
  end

  def build(params) do
    %__MODULE__{}
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:slug)
    |> put_slug()
  end

  defp put_slug(changeset) do
    changeset
    |> get_field(:name)
    |> case do
      nil -> add_error(changeset, :slug, "can't be generated")
      name -> put_change(changeset, :slug, generate_slug(name))
    end
  end

  def generate_slug(name) do
    Slug.slugify(name)
  end
end
