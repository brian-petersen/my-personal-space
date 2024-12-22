defmodule MyPersonalSpaceWeb.PagesController do
  use MyPersonalSpaceWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
