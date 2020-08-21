import Config

config :picoquotes, PicoquotesWeb.Endpoint,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
