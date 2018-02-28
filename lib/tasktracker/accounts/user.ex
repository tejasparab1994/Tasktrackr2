defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User
  alias Tasktracker.Accounts.Manage

  schema "users" do
    field(:name, :string)

    has_many(:manager_manages, Manage, foreign_key: :manager_id)
    has_many(:clients, through: [:manager_manages, :client])
    # to get our clients, get a list of manages table where we are the manager
    # for each of those, our clients are in the clients_id.
    has_one(:client_manages, Manage, foreign_key: :client_id)
    has_one(:managers, through: [:client_manages, :manager])
    # to get our manager, get a list of manages table where we are the client,
    # for each of those, our manager is in the manager_id.
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
