defmodule MyPersonalSpaceWeb.AuthorsHTML do
  use MyPersonalSpaceWeb, :html

  Phoenix.Template.embed_templates("authors_html/*")

  def get_letters() do
    Enum.map(?A..?Z, &<<&1::utf8>>)
  end
end
