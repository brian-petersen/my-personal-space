defmodule PicoquotesWeb.QuotesController do
  use Phoenix.Controller

  alias Picoquotes.Contexts.QuoteContext

  def index(conn, _params) do
    render(conn, "index.html", quotes: QuoteContext.list_quotes())
  end
end
