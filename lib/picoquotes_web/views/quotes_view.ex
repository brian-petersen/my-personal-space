defmodule PicoquotesWeb.QuotesView do
  use PicoquotesWeb.BaseView

  # From https://github.com/spence/valid_url/blob/master/lib/valid_url.ex
  @link_regex Regex.compile!(
                "^" <>
                  "(?:(?:https?|ftp)://)" <>
                  "(?:\\S+(?::\\S*)?@)?" <>
                  "(?:" <>
                  "(?!(?:10|127)(?:\\.\\d{1,3}){3})" <>
                  "(?!(?:169\\.254|192\\.168)(?:\\.\\d{1,3}){2})" <>
                  "(?!172\\.(?:1[6-9]|2\\d|3[0-1])(?:\\.\\d{1,3}){2})" <>
                  "(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])" <>
                  "(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}" <>
                  "(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))" <>
                  "|" <>
                  "(?:(?:[a-z\\x{00a1}-\\x{ffff}0-9]-*)*[a-z\\x{00a1}-\\x{ffff}0-9]+)" <>
                  "(?:\\.(?:[a-z\\x{00a1}-\\x{ffff}0-9]-*)*[a-z\\x{00a1}-\\x{ffff}0-9]+)*" <>
                  "(?:\\.(?:[a-z\\x{00a1}-\\x{ffff}]{2,}))" <>
                  "\\.?" <>
                  ")" <>
                  "(?::\\d{2,5})?" <>
                  "(?:[/?#]\\S*)?" <>
                  "$",
                "iu"
              )

  def render_source(source_text) do
    assigns = %{source_text: source_text}

    ~H"""
    <p class="font-italic font-weight-light">
      Source:

      <%= if is_link?(@source_text) do %>
        <a href={@source_text} target="_blank">
          <%= @source_text %>
        </a>
      <% else %>
        <%= source_text %>
      <% end %>
    </p>
    """
  end

  defp is_link?(text) do
    Regex.match?(@link_regex, text)
  end
end
