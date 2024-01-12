defmodule MyPersonalSpace.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :text
      add :slug, :text

      timestamps()
    end

    create unique_index(:authors, [:slug])
  end
end
