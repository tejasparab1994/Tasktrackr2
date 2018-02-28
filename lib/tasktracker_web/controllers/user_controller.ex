defmodule TasktrackerWeb.UserController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User
  alias Tasktracker.Accounts.Manage

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    users = Accounts.list_users()
    manages = Accounts.manages_map_for(current_user.id)
    render(conn, "index.html", users: users, manages: manages)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns[:current_user]
    user = Accounts.get_user!(id)
    manager = Accounts.get_manager(current_user)

    clients = Accounts.get_clients(current_user)
    manages = Accounts.manages_map_for(current_user.id)

    if manager != nil do
      render(
        conn,
        "show.html",
        user: user,
        manager: manager,
        manages: manages,
        clients: clients
      )
    else
      render(
        conn,
        "show.html",
        user: user,
        manager: "No manager assigned",
        manages: manages,
        clients: clients
      )
    end
  end

  def profile(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "profile.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    conn
    |> delete_session(id)

    {:ok, _user} = Accounts.delete_user(user)

    # some changes here on user deletion
    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
