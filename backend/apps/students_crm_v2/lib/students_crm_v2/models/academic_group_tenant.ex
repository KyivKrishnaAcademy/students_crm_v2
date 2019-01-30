defmodule StudentsCrmV2.Models.AcademicGroupTenant do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.{
    AcademicGroup,
    Tenant
  }

  @type t :: %__MODULE__{}

  schema "academic_groups_tenants" do
    belongs_to(:academic_group, AcademicGroup)
    belongs_to(:tenant, Tenant)

    timestamps()
  end
end
