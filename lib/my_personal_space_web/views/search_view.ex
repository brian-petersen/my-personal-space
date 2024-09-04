defmodule MyPersonalSpaceWeb.SearchView do
  use MyPersonalSpaceWeb.BaseView

  def render_result_text(text) do
    case Earmark.as_html(text) do
      {:ok, html, _errors} -> PhoenixHtmlSanitizer.Helpers.sanitize(html, :strip_tags)
      _ -> text
    end
  end
end
