# MyPersonalSpace

My space on the internet.

## Getting Started

1. Install `mise`
1. Set up Elixir and Erlang versions used by project: `mise install`
1. Install dependencies: `mix deps.get`
1. Compile the code: `mix compile`
1. Set up the database: `mix ecto.setup` (sqlite is used for the database)
1. Seed the database with dev data (optional): `mix run priv/repo/dev_seeds.exs`
1. Run the server: `iex -S mix phx.server`
1. Navigate to http://localhost:4000

## Common Maintenance Tasks

### Updating Dependencies

- Run `mix hex.outdated` to see status of deps
- Run `mix deps.update --all` to update deps that won't break (according to semver)
- To update other deps, edit `mix.exs` with the new version and run `mix deps.get`

### Updating Erlang/Elixir

For new versions of either:

1. Update `.tool-versions`
1. Run `mise install`
1. Update `Dockerfile`
    - For this one you need to match the Dockerimage base image with the proper version in Dockerhub
    - See https://hub.docker.com/r/hexpm/elixir for available image tags

### Deploying

The images are built and pushed to GitHub. As a prereq:

    op read "op://Personal/GitHub Package Publishing PAT/password" | docker login ghcr.io -u USERNAME --password-stdin

That only needs to be done one time.

1. Build the image: `docker build -t ghcr.io/brian-petersen/my-personal-space:latest .`
1. Push the image: `docker push ghcr.io/brian-petersen/my-personal-space:latest`
1. Roll the pod in the k8s cluster

### Connect to Producton via `iex`

1. Connect to production instance
1. Connect to running system via iex: `./bin/my_personal_space remote`
