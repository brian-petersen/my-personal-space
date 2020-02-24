defmodule Picoquotes.Application do
  use Application

  def start(_type, _args) do
    children = [
      Picoquotes.Repo,
      {Plug.Cowboy, scheme: :http, plug: Picoquotes.Router, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: Picoquotes.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
