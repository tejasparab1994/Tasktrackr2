defmodule Tasktracker.Social.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Task
  alias Tasktracker.Social.Timeblock

  schema "tasks" do
    field(:body, :string)
    field(:completed, :boolean, default: false)
    field(:title, :string)
    belongs_to(:user, Tasktracker.Accounts.User, foreign_key: :assigned_id)
    field(:time_taken, :integer)
    # has_many(:manager_manages, Manage, foreign_key: :manager_id)
    # has_many(:clients, through: [:manager_manages, :client])
    # has_one(:client_manages, Manage, foreign_key: :client_id)
    # has_one(:managers, through: [:client_manages, :manager])
    #
    # has_many(:tasks_times, , foreign_key: :task_id)
    # has_many(:timeblocks, through: [:tasks_times, :task_id])

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :body, :completed, :assigned_id, :time_taken])
    |> validate_required([:title, :body, :completed, :assigned_id, :time_taken])
    |> validate_change(:time_taken, fn :time_taken, f ->
      if rem(f, 15) == 0 do
        []
      else
        [time_taken: "Invalid input, not a multiple of 15"]
      end
    end)
  end
end
