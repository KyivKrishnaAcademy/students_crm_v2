defmodule StudentsCrmV2.Models.AcademicGroup do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.Tenant

  @type t :: %__MODULE__{}

  schema "academic_groups" do
    field(:established_on, :date)

    field(:name, :string)
    field(:description, :string)

    many_to_many(:tenants, Tenant, join_through: "academic_groups_tenants")

    timestamps()
  end
end
