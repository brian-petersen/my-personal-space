import Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :picoquotes, PicoquotesWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000],
  url: [host: "picoquotes.luckywatcher.dev", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true

config :picoquotes, Picoquotes.Repo, socket_options: [:inet6]

# Do not print debug messages in production
config :logger, level: :info
