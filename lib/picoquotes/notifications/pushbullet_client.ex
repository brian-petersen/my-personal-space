defmodule Picoquotes.Notifications.PushbulletClient do
  import Tesla, only: [post: 3]

  @behaviour Picoquotes.Notifications.Client

  def create_link_push(title, body, url) do
    post(client(), "/pushes", %{
      type: "link",
      title: title,
      body: body,
      url: url
    })
  end

  def create_note_push(title, body) do
    post(client(), "/pushes", %{
      type: "note",
      title: title,
      body: body
    })
  end

  defp client() do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, "https://api.pushbullet.com/v2"},
      {Tesla.Middleware.Headers, [{"access-token", pushbullet_api_token()}]},
      Tesla.Middleware.JSON
    ])
  end

  defp pushbullet_api_token() do
    Confex.get_env(:picoquotes, :pushbullet_api_token)
  end
end
