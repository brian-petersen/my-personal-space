defmodule MyPersonalSpaceWeb.PagesControllerTest do
  use MyPersonalSpace.ConnCase

  describe "GET / (home page)" do
    test "returns 200 status and renders home page", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Hey there!"
    end
  end
end
