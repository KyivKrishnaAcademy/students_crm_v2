defmodule StudentsCrmV2.Models.GroupParticipation do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.{
    AcademicGroup,
    Tenant,
    User
  }

  @type t :: %__MODULE__{}

  @leave_reasons ~w[graduation manual]

  schema "group_participations" do
    field(:join_time, :utc_datetime)
    field(:leave_time, :utc_datetime)

    field(:leave_reason, :string)

    belongs_to(:academic_group, AcademicGroup)
    belongs_to(:tenant, Tenant)
    belongs_to(:user, User)

    timestamps()
  end

  def leave_reasons, do: @leave_reasons
end
