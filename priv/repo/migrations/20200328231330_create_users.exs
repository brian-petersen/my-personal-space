defmodule Picoquotes.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :text
      add :password_hash, :text

      timestamps()
    end

    create index(:users, [:username], unique: true)
  end
end
