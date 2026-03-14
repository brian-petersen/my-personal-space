defmodule MyPersonalSpaceWeb.SearchHTML do
  use MyPersonalSpaceWeb, :html

  Phoenix.Template.embed_templates("search_html/*")

  def render_result_text(text) do
    case Earmark.as_html(text) do
      {:ok, html, _errors} -> PhoenixHtmlSanitizer.Helpers.sanitize(html, :strip_tags)
      _ -> text
    end
  end
end
