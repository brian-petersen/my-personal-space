# MyPersonalSpace

My space on the internet.

## Getting Started

1. Install `asdf`: https://asdf-vm.com/guide/getting-started.html
1. Set up Elixir and Erlang versions used by project: `asdf install`
1. Install dependencies: `mix deps.get`
1. Compile the code: `mix compile`
1. Set up the database: `mix ecto.setup` (sqlite is used for the database)
1. Seed the database with dev data (optional): `mix run priv/repo/dev_seeds.exs`
1. Run the server: `iex -S mix phx.server`
1. Navigate to http://localhost:4000
