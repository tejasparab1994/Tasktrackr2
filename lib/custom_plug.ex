defmodule TasktrackerWebAdd do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    if user_id do
      user = Tasktracker.Accounts.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end
end
