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

## Common Maintenance Tasks

### Updating Dependencies

- Run `mix hex.outdated` to see status of deps
- Run `mix deps.update --all` to update deps that follow semver
- To update other deps, edit `mix.exs` with the new version and run `mix deps.get`

### Updating Erlang/Elixir

For new versions of either:

1. Update `.tool-versions`
1. Run `asdf install`
1. Update `Dockerfile`
    - For this one you need to match the Dockerimage base image with the proper version in Dockerhub
    - See https://hub.docker.com/r/hexpm/elixir for available image tags
