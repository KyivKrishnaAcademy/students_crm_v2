defmodule StudentsCrmV2.Models.Tenant do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.User

  @type t :: %__MODULE__{}

  schema "tenants" do
    field(:name, :string)

    many_to_many(:users, User, join_through: "tenants_users")

    timestamps()
  end
end
