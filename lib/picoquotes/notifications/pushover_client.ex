defmodule Picoquotes.Notifications.PushoverClient do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.pushover.net/1"
  plug Tesla.Middleware.JSON

  @behaviour Picoquotes.Notifications.Client

  def create_link_push(title, message, url) do
    post("/messages.json", %{
      token: pushbullet_api_token(),
      user: pushbullet_user_token(),
      message: message,
      title: title,
      url: url
    })
  end

  def create_note_push(title, message) do
    post("/messages.json", %{
      token: pushbullet_api_token(),
      user: pushbullet_user_token(),
      message: message,
      title: title
    })
  end

  defp pushbullet_api_token() do
    Confex.get_env(:picoquotes, :pushover_api_token)
  end

  defp pushbullet_user_token() do
    Confex.get_env(:picoquotes, :pushover_user_token)
  end
end
