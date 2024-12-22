defmodule MyPersonalSpaceWeb.LayoutHelpers do
  def get_search_query(conn) do
    conn
    |> Plug.Conn.fetch_query_params()
    |> Map.get(:query_params)
    |> Map.get("query")
  end
end
