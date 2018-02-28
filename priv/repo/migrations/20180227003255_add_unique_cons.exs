defmodule Tasktracker.Repo.Migrations.AddUniqueCons do
  use Ecto.Migration

  def change do
    drop(index(:manages, [:client_id]))
    create(unique_index(:manages, [:client_id]))
  end
end
