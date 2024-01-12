defmodule MyPersonalSpace.Repo do
  use Ecto.Repo,
    otp_app: :my_personal_space,
    adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    database_url = Confex.get_env(:my_personal_space, :database_url)

    {:ok, Keyword.put(config, :url, database_url)}
  end
end
