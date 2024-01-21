defmodule MyPersonalSpace.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :text, null: false

      timestamps()
    end

    create index(:categories, [:name], unique: true)
  end
end
