defmodule Picoquotes.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: Picoquotes.PubSub},
      Picoquotes.Repo,
      Picoquotes.Scheduler,
      PicoquotesWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Picoquotes.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PicoquotesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
