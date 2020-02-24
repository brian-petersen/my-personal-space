import Config

config :picoquotes,
  ecto_repos: [Picoquotes.Repo]

config :picoquotes,
       :database_url,
       {:system, :string, "DATABASE_URL", "ecto://postgres:postgres@db/picoquotes"}
