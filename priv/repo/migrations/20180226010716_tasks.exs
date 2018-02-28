defmodule Tasktracker.Repo.Migrations.Tasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add(:title, :string, null: false)
      add(:body, :text, null: false)
      add(:completed, :boolean, null: false, default: false)
      add(:assigned_id, references(:users, on_delete: :delete_all), null: false)
      add(:time_taken, :integer, default: 0)
      timestamps()
    end
  end
end
