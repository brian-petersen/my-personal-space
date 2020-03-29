defmodule PicoquotesWeb.SessionsController do
  use Phoenix.Controller

  alias Picoquotes.Contexts.UserContext
  alias Picoquotes.Models.User
  alias PicoquotesWeb.Router.Helpers, as: Routes

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"username" => username, "password" => password} = _params) do
    with user when not is_nil(user) <- UserContext.get_user_by_username(username),
         true <- User.has_password?(user, password) do
      conn
      |> put_flash(:info, "Welcome back, my friend!")
      |> put_session(:user_id, user.id)
      |> configure_session(renew: true)
      |> redirect(to: Routes.quotes_path(conn, :index))
    else
      _ ->
        conn
        |> put_flash(:error, "Invalid username or password.")
        |> redirect(to: Routes.sessions_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> put_flash(:info, "Successfully signed out, my friend.")
    |> configure_session(renew: true)
    |> redirect(to: Routes.quotes_path(conn, :index))
  end
end
