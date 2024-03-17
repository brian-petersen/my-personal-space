defmodule MyPersonalSpace.Repo.Migrations.AddIndexedTables do
  use Ecto.Migration

  def change do
    # Author index and bits to keep it up to date
    execute(
      "CREATE VIRTUAL TABLE authors_index USING fts5 (name, slug UNINDEXED, content=authors, content_rowid=id)",
      "DROP TABLE authors_index"
    )

    execute(
      "INSERT INTO authors_index (rowid, name, slug) SELECT id, name, slug FROM authors",
      "DELETE FROM authors_index"
    )

    execute(
      """
      CREATE TRIGGER authors_after_insert AFTER INSERT ON authors BEGIN
        INSERT INTO authors_index (rowid, name, slug) VALUES (new.id, new.name, new.slug);
      END
      """,
      "DROP TRIGGER authors_after_insert"
    )

    execute(
      """
      CREATE TRIGGER authors_after_delete AFTER DELETE ON authors BEGIN
        INSERT INTO authors_index(authors_index, rowid, name, slug) VALUES ('delete', old.id, old.name, old.slug);
      END
      """,
      "DROP TRIGGER authors_after_delete"
    )

    execute(
      """
      CREATE TRIGGER authors_after_update AFTER UPDATE ON authors BEGIN
        INSERT INTO authors_index(authors_index, rowid, name, slug) VALUES ('delete', old.id, old.name, old.slug);
        INSERT INTO authors_index (rowid, name, slug) VALUES (new.id, new.name, new.slug);
      END;
      """,
      "DROP TRIGGER authors_after_update"
    )

    # Quote index and bits to keep it up to date
    execute(
      "CREATE VIRTUAL TABLE quotes_index USING fts5 (text, permalink, content=quotes, content_rowid=id)",
      "DROP TABLE quotes_index"
    )

    execute(
      "INSERT INTO quotes_index (rowid, text, permalink) SELECT id, text, permalink FROM quotes",
      "DELETE FROM quotes_index"
    )

    execute(
      """
      CREATE TRIGGER quotes_after_insert AFTER INSERT ON quotes BEGIN
        INSERT INTO quotes_index (rowid, text, permalink) VALUES (new.id, new.text, new.permalink);
      END
      """,
      "DROP TRIGGER quotes_after_insert"
    )

    execute(
      """
      CREATE TRIGGER quotes_after_delete AFTER DELETE ON quotes BEGIN
        INSERT INTO quotes_index(quotes_index, rowid, text, permalink) VALUES ('delete', old.id, old.text, old.permalink);
      END
      """,
      "DROP TRIGGER quotes_after_delete"
    )

    execute(
      """
      CREATE TRIGGER quotes_after_update AFTER UPDATE ON quotes BEGIN
        INSERT INTO quotes_index(quotes_index, rowid, text, permalink) VALUES ('delete', old.id, old.text, old.permalink);
        INSERT INTO quotes_index (rowid, text, permalink) VALUES (new.id, new.text, new.permalink);
      END;
      """,
      "DROP TRIGGER quotes_after_update"
    )
  end
end
