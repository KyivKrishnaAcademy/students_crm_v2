defmodule StudentsCrmV2Web.AcademicGroupView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  attributes([
    :description,
    :established_on,
    :name
  ])

  has_many(:students, links: [related: "/api/v1/academic_groups/:id/students?page%5Bsize%5D=1000"])
end
