import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :my_personal_space, MyPersonalSpaceWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Configure your database
config :my_personal_space, MyPersonalSpace.Repo, pool: Ecto.Adapters.SQL.Sandbox
