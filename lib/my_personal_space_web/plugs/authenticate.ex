defmodule MyPersonalSpaceWeb.Plugs.Authenticate do
  alias MyPersonalSpaceWeb.Authentication

  import Plug.Conn

  def init(default) do
    default
  end

  def call(conn, _default) do
    if Authentication.signed_in?(conn) do
      conn
    else
      conn
      |> send_resp(401, "Not authorized")
      |> halt()
    end
  end
end
