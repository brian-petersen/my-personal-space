defmodule PicoquotesWeb.PagesController do
  use Phoenix.Controller

  def home(conn, _params) do
    render(conn, "home.html")
  end
end
