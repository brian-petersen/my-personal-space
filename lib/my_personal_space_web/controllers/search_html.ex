defmodule MyPersonalSpaceWeb.SearchHTML do
  use MyPersonalSpaceWeb, :html

  Phoenix.Template.embed_templates("search_html/*")

  def render_result_text(text) do
    text |> MDEx.to_html!() |> PhoenixHtmlSanitizer.Helpers.sanitize(:strip_tags)
  end
end
