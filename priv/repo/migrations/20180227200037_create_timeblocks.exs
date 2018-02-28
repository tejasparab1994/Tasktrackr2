defmodule Tasktracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add(:start_time, :string)
      add(:end_time, :string)
      add(:task_id, references(:tasks, on_delete: :delete_all))
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps()
    end

    create(index(:timeblocks, [:task_id]))
    create(index(:timeblocks, [:user_id]))
  end
end
