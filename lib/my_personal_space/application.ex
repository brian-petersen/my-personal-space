defmodule MyPersonalSpace.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: MyPersonalSpace.PubSub},
      MyPersonalSpace.Repo,
      MyPersonalSpace.Scheduler,
      MyPersonalSpaceWeb.Telemetry,
      MyPersonalSpaceWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: MyPersonalSpace.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MyPersonalSpaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
