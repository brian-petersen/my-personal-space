defmodule MyPersonalSpaceWeb.SessionsControllerTest do
  use MyPersonalSpace.ConnCase

  import MyPersonalSpace.Fixtures.UserFixtures

  describe "GET /sessions/new (login page)" do
    test "returns 200 status and renders login form", %{conn: conn} do
      conn = get(conn, "/sessions/new")
      response = html_response(conn, 200)

      assert response =~ "Sign In"
    end

    test "renders login form with username pre-filled when provided", %{conn: conn} do
      conn = get(conn, "/sessions/new", username: "testuser")
      response = html_response(conn, 200)

      assert response =~ "testuser"
    end
  end

  describe "POST /sessions (login)" do
    test "creates session and redirects for valid credentials", %{conn: conn} do
      password = valid_password()
      user = user_fixture(password: password)

      conn =
        post(conn, "/sessions", %{
          "user" => %{
            "username" => user.username,
            "password" => password
          }
        })

      assert redirected_to(conn, 302)
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Welcome back"
    end

    test "redirects to login with error for invalid credentials", %{conn: conn} do
      conn =
        post(conn, "/sessions", %{
          "user" => %{
            "username" => "nonexistent",
            "password" => "wrongpassword"
          }
        })

      assert redirected_to(conn, 302)
      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~ "Invalid"
    end
  end

  describe "DELETE /sessions (logout)" do
    test "clears session and redirects", %{conn: conn} do
      conn = authenticated_conn(conn)

      conn = delete(conn, "/sessions")

      assert redirected_to(conn, 302)
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Successfully signed out"
    end
  end
end
