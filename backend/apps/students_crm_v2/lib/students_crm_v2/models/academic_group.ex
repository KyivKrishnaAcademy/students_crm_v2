defmodule StudentsCrmV2.Models.AcademicGroup do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.Tenant

  @type t :: %__MODULE__{}

  schema "academic_groups" do
    field(:established_on, :date)

    field(:name, :string)
    field(:description, :string)

    belongs_to(:tenant, Tenant)

    timestamps()
  end
end
