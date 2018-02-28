defmodule TasktrackerWeb.SessionController do
  use TasktrackerWeb, :controller

  def create(conn, %{"name" => name}) do
    user = Tasktracker.Accounts.get_user_by_name(name)

    if user do
      # put_session: add something to session
      # store that id into session
      # storing user id instead of user object
      # data stored in cookie, and particular size given to cookie
      # but if we send entire structure then cookie size increases
      # good enough for now, but when structure gets bigger, need to worry
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome Back, #{user.name}")
      |> redirect(to: "/feed")
    else
      conn
      |> put_flash(:error, "Incorrect Name or Unregistered")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "You have logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
