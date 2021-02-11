defmodule Picoquotes.Notifications do
  alias Picoquotes.Contexts.QuoteContext
  alias Picoquotes.Models.Quote
  alias Picoquotes.Notifications.PushbulletClient

  require Logger

  @doc """
  Sends a push notification for a quote.

  Assumes that the quote's author is preloaded.
  """
  def send_quote_notification(%Quote{text: text, author: %{name: name}}) do
    PushbulletClient.create_note_push("Quote of the Day", "#{text}\n- #{name}")
  end

  def send_random_quote() do
    Logger.info("Sending random quote")

    QuoteContext.get_random_quote() |> send_quote_notification()
  end
end
