defmodule Picoquotes.Tasks.Migrate do
  require Logger

  @repo_apps [
    :crypto,
    :ssl,
    :postgrex,
    :ecto_sql
  ]

  @repos Application.get_env(:picoquotes, :ecto_repos, [])

  def run do
    {:ok, _} = Application.ensure_all_started(:logger)
    Logger.info("Performing migrations...")

    start_services()
    run_migrations()
    stop_services()
  end

  defp start_services do
    Logger.info("Starting dependencies...")
  
    Enum.each(@repo_apps, fn app ->
      {:ok, _} = Application.ensure_all_started(app)
    end)

    Logger.info("Starting repos...")
    :ok = Application.load(:picoquotes)

    Enum.each(@repos, fn repo ->
      {:ok, _} = repo.start_link(pool_size: 2)
    end)
  end

  defp run_migrations do
    Enum.each(@repos, &run_migrations_for/1)
  end

  defp run_migrations_for(repo) do
    Logger.info("Performing migrations for #{inspect(repo)}...")
    Ecto.Migrator.run(repo, Ecto.Migrator.migrations_path(repo), :up, all: true)
  end

  defp stop_services do
    Logger.info("Finished migrating!")
    :init.stop()
  end
end
