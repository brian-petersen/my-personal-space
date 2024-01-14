defmodule MyPersonalSpace.Repo.Migrations.AddPermalinkToQuotes do
  use Ecto.Migration

  def up do
    # I edited this manually as I move from Postgres to SQLite.
    # I know it's not generally advised... but I had to migrate
    # the data manually anyways.

    # alter table(:quotes) do
    #   add :permalink, :text
    # end

    # execute(fn ->
    #   %{rows: rows} = repo().query!("select id from quotes")
    #   ids = Enum.flat_map(rows, & &1)
    #
    #   Enum.each(ids, fn id ->
    #     repo().query!("update quotes set permalink = $1 where id = $2", [
    #       generate_permalink(),
    #       id
    #     ])
    #   end)
    # end)

    alter table(:quotes) do
      add :permalink, :text, null: false
    end

    create unique_index(:quotes, :permalink)
  end

  def down do
    alter table(:quotes) do
      remove :permalink
    end
  end

  # defp generate_permalink() do
  #   16
  #   |> :crypto.strong_rand_bytes()
  #   |> Base.url_encode64(padding: false)
  # end
end
