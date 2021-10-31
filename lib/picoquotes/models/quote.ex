defmodule Picoquotes.Models.Quote do
  use Ecto.Schema

  alias Picoquotes.Models.Author

  import Ecto.Changeset

  schema "quotes" do
    field(:text, :string)
    field(:text_rendered, :string)
    field(:source, :string)
    field(:permalink, :string)

    belongs_to(:author, Author)

    timestamps()
  end

  def build(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [:text, :author_id, :source])
    |> validate_required([:text, :author_id])
    |> assoc_constraint(:author)
    |> validate_and_render_text()
  end

  defp validate_and_render_text(changeset) do
    with {:ok, text} <- fetch_change(changeset, :text),
         {:ok, text_rendered, _errors} <- Earmark.as_html(text, compact_output: true) do
      put_change(changeset, :text_rendered, text_rendered)
    else
      :error ->
        changeset

      {:error, _html, _errors} ->
        add_error(changeset, :text, "Quote text contains improper markdown")
    end
  end

  def generate_permalink() do
    16
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64(padding: false)
  end
end
