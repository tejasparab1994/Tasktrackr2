defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Social
  alias Tasktracker.Accounts

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def feed(conn, _params) do
    tasks = Social.list_tasks()
    render(conn, "feed.html", tasks: tasks)
  end

  def report(conn, _params) do
    tasks = Social.list_tasks()
    current_user = conn.assigns[:current_user]
    clients = Accounts.get_clients(current_user)
    render(conn, "report.html", tasks: tasks, clients: clients)
  end

  def timeblock(conn, %{"task" => task}) do
    current_user = conn.assigns[:current_user]
    task = Social.get_task!(task)
    timeblocks = Social.get_my_timeblock(current_user.id, task.id)
    # IO.inspect(Enum.at(timeblocks, 0))
    alltimeblocks = Social.get_timeblock(task.id)

    if Enum.at(timeblocks, 0) == nil do
      id = ""
    else
      id = Enum.at(timeblocks, 0).id
    end

    changeset = Social.change_timeblock(%Tasktracker.Social.Timeblock{})
    # IO.inspect(id)
    # IO.inspect(timeblocks)
    # IO.inspect(id)
    render(
      conn,
      "timeblock.html",
      task: task,
      id: id,
      changeset: changeset,
      timeblocks: timeblocks,
      alltimeblocks: alltimeblocks
    )
  end
end
