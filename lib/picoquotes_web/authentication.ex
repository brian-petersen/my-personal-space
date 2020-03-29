defmodule PicoquotesWeb.Authentication do
  alias Plug.Conn

  def signed_in?(conn) do
    not is_nil(Conn.get_session(conn, :user_id))
  end
end
