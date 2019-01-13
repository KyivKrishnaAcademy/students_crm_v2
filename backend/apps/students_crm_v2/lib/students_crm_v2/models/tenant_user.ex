defmodule StudentsCrmV2.Models.TenantUser do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.{
    Tenant,
    User
  }

  @type t :: %__MODULE__{}

  schema "tenants_users" do
    belongs_to(:tenant, Tenant)
    belongs_to(:user, User)

    timestamps()
  end
end
