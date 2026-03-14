defmodule MyPersonalSpace.Notifications.PushoverClient do
  @behaviour MyPersonalSpace.Notifications.Client

  defp client do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, "https://api.pushover.net/1"},
      Tesla.Middleware.JSON
    ])
  end

  def create_link_push(title, message, url) do
    Tesla.post(client(), "/messages.json", %{
      token: pushbullet_api_token(),
      user: pushbullet_user_token(),
      message: message,
      title: title,
      url: url
    })
  end

  def create_note_push(title, message) do
    Tesla.post(client(), "/messages.json", %{
      token: pushbullet_api_token(),
      user: pushbullet_user_token(),
      message: message,
      title: title
    })
  end

  defp pushbullet_api_token() do
    Confex.get_env(:my_personal_space, :pushover_api_token)
  end

  defp pushbullet_user_token() do
    Confex.get_env(:my_personal_space, :pushover_user_token)
  end
end
