defmodule StudentsCrmV2Web.GroupParticipationView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  alias StudentsCrmV2Web.{
    AcademicGroupView,
    UserView
  }

  attributes([
    :join_time,
    :leave_reason,
    :leave_time
  ])

  has_one(:academic_group, serializer: AcademicGroupView, include: true)
  has_one(:user, serializer: UserView, include: false)
end
