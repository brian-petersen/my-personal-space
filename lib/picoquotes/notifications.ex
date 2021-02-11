defmodule Picoquotes.Notifications do
  alias Picoquotes.Models.Quote
  alias Picoquotes.Notifications.PushbulletClient

  @doc """
  Sends a push notification for a quote.

  Assumes that the quote's author is preloaded.
  """
  def send_quote_notification(%Quote{text: text, author: %{name: name}}) do
    PushbulletClient.create_note_push("Quote of the Day", "#{text} - #{name}")
  end
end
