defmodule MyPersonalSpaceWeb.LayoutHTML do
  use MyPersonalSpaceWeb, :html

  Phoenix.Template.embed_templates("layout_html/*")

  def get_search_query(conn) do
    conn
    |> Plug.Conn.fetch_query_params()
    |> Map.get(:query_params)
    |> Map.get("query")
  end
end
