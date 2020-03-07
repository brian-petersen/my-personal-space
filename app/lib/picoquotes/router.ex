defmodule Picoquotes.Router do
  use Plug.Router

  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  forward("/graphql", to: Absinthe.Plug, schema: Picoquotes.Schema)
  forward("/graphiql", to: Absinthe.Plug.GraphiQL, schema: Picoquotes.Schema)

  forward("/static", to: Plug.Static, at: "/", from: "static")

  match _ do
    send_file(conn, 200, "static/index.html")
  end
end
