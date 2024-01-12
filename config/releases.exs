import Config

config :my_personal_space, MyPersonalSpaceWeb.Endpoint, secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
