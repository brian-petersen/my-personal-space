defmodule MyPersonalSpace.Repo.Migrations.AddSourceToQuotes do
  use Ecto.Migration

  def change do
    alter table(:quotes) do
      add :source, :text
    end
  end
end
