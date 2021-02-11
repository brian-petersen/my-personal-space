import Config

# Configures the database url
config :picoquotes,
       :database_url,
       {:system, :string, "DATABASE_URL", "ecto://postgres:postgres@db/picoquotes"}

# Other
config :picoquotes, :pushbullet_api_token, {:system, :string, "PUSHBULLET_API_TOKEN"}

config :picoquotes, Picoquotes.Scheduler,
  timezone: "America/Denver",
  jobs: [
    {"0 9 * * *", &Picoquotes.Notifications.send_random_quote/0}
  ]

# Configures Ecto repos for project
config :picoquotes,
  ecto_repos: [Picoquotes.Repo]

# Configures the endpoint
config :picoquotes, PicoquotesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Zm0bY+2g6Ywx2bQXfHi2vmK1JMKyDZ7VP3K+0G8/CzdINXskfUqH+gHBfKlxOvXP",
  render_errors: [view: PicoquotesWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Picoquotes.PubSub,
  live_view: [signing_salt: "SEJ60pgc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use updated timezone data
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
