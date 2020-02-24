defmodule Picoquotes.Repo do
  use Ecto.Repo,
    otp_app: :picoquotes,
    adapter: Ecto.Adapters.Postgres
end
