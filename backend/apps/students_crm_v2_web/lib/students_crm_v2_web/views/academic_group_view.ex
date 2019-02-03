defmodule StudentsCrmV2Web.AcademicGroupView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  attributes([
    :description,
    :established_on,
    :name
  ])
end
