defmodule MyPersonalSpace.Application do
  use Application

  require Logger

  def start(_type, _args) do
    run_migratons()

    children = [
      {Phoenix.PubSub, name: MyPersonalSpace.PubSub},
      MyPersonalSpace.Repo,
      MyPersonalSpace.Scheduler,
      MyPersonalSpace.Shortener,
      MyPersonalSpaceWeb.Telemetry,
      MyPersonalSpaceWeb.Endpoint,
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

  defp run_migratons() do
    if Confex.get_env(:my_personal_space, :run_migrations) do
      Logger.info("Running migrations...")
      MyPersonalSpace.Release.migrate()
      Logger.info("Finished migrations...")
    end
  end
end
