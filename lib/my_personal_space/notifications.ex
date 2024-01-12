defmodule MyPersonalSpace.Notifications do
  alias MyPersonalSpace.Contexts.QuoteContext
  alias MyPersonalSpace.Models.Quote
  alias MyPersonalSpace.Notifications.PushoverClient

  require Logger

  @doc """
  Sends a push notification for a quote.

  Assumes that the quote's author is preloaded.
  """
  def send_quote_notification(%Quote{} = quote) do
    body = """
    #{quote.text}

    - #{quote.author.name}
    (#{quote.source})
    """

    PushoverClient.create_note_push("Quote of the Day", body)
  end

  def send_random_quote() do
    Logger.info("Sending random quote")

    QuoteContext.get_random_quote() |> send_quote_notification()
  end
end
