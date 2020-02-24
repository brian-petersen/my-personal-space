defmodule Picoquotes.Repo do
  use Ecto.Repo,
    otp_app: :picoquotes,
    adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    database_url = Confex.get_env(:picoquotes, :database_url)

    {:ok, Keyword.put(config, :url, database_url)}
  end
end
