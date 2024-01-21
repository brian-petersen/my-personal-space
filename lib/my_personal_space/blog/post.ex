defmodule MyPersonalSpace.Blog.Post do
  use Ecto.Schema

  import Ecto.Changeset

  schema "posts" do
    field :permalink, :string
    field :text, :string
    field :text_rendered, :string

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:text])
    |> validate_required([:text])
    |> validate_and_render_text()
    |> upsert_permalink()
  end

  defp generate_permalink() do
    16
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64(padding: false)
  end

  defp upsert_permalink(changeset) do
    permalink = get_field(changeset, :permalink)

    if permalink do
      changeset
    else
      put_change(changeset, :permalink, generate_permalink())
    end
  end

  defp validate_and_render_text(changeset) do
    with {:ok, text} <- fetch_change(changeset, :text),
         {:ok, text_rendered, _errors} <- Earmark.as_html(text, compact_output: true) do
      put_change(changeset, :text_rendered, text_rendered)
    else
      :error ->
        changeset

      {:error, _html, _errors} ->
        add_error(changeset, :text, "Post text contains improper markdown")
    end
  end
end
