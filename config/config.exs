import Config

config :esbuild,
  version: "0.12.26",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Other
config :my_personal_space, :pushbullet_api_token, {:system, :string, "PUSHBULLET_API_TOKEN"}

config :my_personal_space, :pushover_api_token, {:system, :string, "PUSHOVER_API_TOKEN"}
config :my_personal_space, :pushover_user_token, {:system, :string, "PUSHOVER_USER_TOKEN"}

config :my_personal_space, MyPersonalSpace.Scheduler,
  timezone: "America/Denver",
  jobs: [
    # {"0 9 * * *", &MyPersonalSpace.Notifications.send_random_quote/0}
  ]

# Configures Ecto repos for project
config :my_personal_space,
  ecto_repos: [MyPersonalSpace.Repo]

config :my_personal_space, MyPersonalSpace.Repo, database: "db/my_personal_space.db"

# Configures the endpoint
config :my_personal_space, MyPersonalSpaceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Zm0bY+2g6Ywx2bQXfHi2vmK1JMKyDZ7VP3K+0G8/CzdINXskfUqH+gHBfKlxOvXP",
  render_errors: [view: MyPersonalSpaceWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: MyPersonalSpace.PubSub,
  live_view: [signing_salt: "SEJ60pgc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :logger,
  handle_otp_reports: true,
  handle_sasl_reports: true

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use updated timezone data
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
