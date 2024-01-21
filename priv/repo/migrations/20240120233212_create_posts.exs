defmodule MyPersonalSpace.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :permalink, :text, null: false
      add :text, :text, null: false
      add :text_rendered, :text, null: false

      timestamps()
    end

    create index(:posts, [:permalink], unique: true)
  end
end
