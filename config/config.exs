import Config

config :picoquotes,
  ecto_repos: [Picoquotes.Repo]

config :picoquotes, Picoquotes.Repo,
  database: "picoquotes",
  username: "postgres",
  password: "postgres",
  hostname: "db",
  port: 5432
