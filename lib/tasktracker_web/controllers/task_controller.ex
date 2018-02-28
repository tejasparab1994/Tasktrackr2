defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Social
  alias Tasktracker.Social.Task
  alias Tasktracker.Accounts

  def index(conn, _params) do
    tasks = Social.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    users = Accounts.list_users()
    changeset = Social.change_task(%Task{})
    current_user = conn.assigns[:current_user]
    clients = Accounts.get_clients(current_user)
    render(conn, "new.html", changeset: changeset, users: users, clients: clients)
  end

  def create(conn, %{"task" => task_params}) do
    users = Accounts.list_users()
    current_user = conn.assigns[:current_user]
    clients = Accounts.get_clients(current_user)

    case Social.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users, clients: clients)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Social.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    users = Accounts.list_users()
    task = Social.get_task!(id)
    changeset = Social.change_task(task)
    current_user = conn.assigns[:current_user]
    clients = Accounts.get_clients(current_user)
    render(conn, "edit.html", task: task, changeset: changeset, users: users, clients: clients)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Social.get_task!(id)
    users = Accounts.list_users()
    current_user = conn.assigns[:current_user]
    clients = Accounts.get_clients(current_user)

    case Social.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(
          conn,
          "edit.html",
          task: task,
          changeset: changeset,
          users: users,
          clients: clients
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Social.get_task!(id)
    {:ok, _task} = Social.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
