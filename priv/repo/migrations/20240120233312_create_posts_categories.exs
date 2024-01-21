defmodule MyPersonalSpace.Repo.Migrations.CreatePostsCategories do
  use Ecto.Migration

  def change do
    create table(:posts_categories, primary_key: false) do
      add :post_id, references(:posts), primary_key: true
      add :category_id, references(:categories), primary_key: true

      timestamps()
    end
  end
end
