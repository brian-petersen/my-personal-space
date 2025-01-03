defmodule MyPersonalSpaceWeb.SessionsController do
  use MyPersonalSpaceWeb, :controller

  alias MyPersonalSpace.Contexts.UserContext
  alias MyPersonalSpace.Models.User
  alias MyPersonalSpaceWeb.Router.Helpers, as: Routes

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"username" => username, "password" => password} = _params) do
    redirect = get_referer_redirect(conn)

    with user when not is_nil(user) <- UserContext.get_user_by_username(username),
         true <- User.has_password?(user, password) do
      conn
      |> put_flash(:info, "Welcome back, my friend!")
      |> put_session(:user_id, user.id)
      |> configure_session(renew: true)
      |> redirect(to: redirect)
    else
      _ ->
        conn
        |> put_flash(:error, "Invalid username or password.")
        |> redirect(to: Routes.sessions_path(conn, :new, redirect: redirect))
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> put_flash(:info, "Successfully signed out, my friend.")
    |> configure_session(renew: true)
    |> redirect(to: get_signout_redirect(conn))
  end

  defp get_referer_redirect(conn) do
    with [referer] <- Plug.Conn.get_req_header(conn, "referer"),
         uri <- URI.parse(referer),
         query when not is_nil(query) <- Map.get(uri, :query),
         decoded <- URI.decode_query(query),
         redirect when not is_nil(redirect) <- Map.get(decoded, "redirect") do
      redirect
    else
      _ ->
        Routes.pages_path(conn, :home)
    end
  end

  defp get_signout_redirect(conn) do
    with [referer] <- Plug.Conn.get_req_header(conn, "referer"),
         uri <- URI.parse(referer),
         path when not is_nil(path) <- Map.get(uri, :path) do
      path
    else
      _ ->
        Routes.pages_path(conn, :home)
    end
  end
end
