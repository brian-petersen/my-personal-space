defmodule MyPersonalSpace.Repo do
  use Ecto.Repo,
    otp_app: :my_personal_space,
    adapter: Ecto.Adapters.SQLite3
end
