defmodule Picoquotes.Repo.Migrations.AddTextRenderedToQuotes do
  use Ecto.Migration

  def change do
    alter table(:quotes) do
      add :text_rendered, :text
    end
  end
end
