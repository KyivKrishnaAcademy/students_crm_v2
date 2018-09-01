defmodule StudentsCrmV2Web.SessionView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  alias StudentsCrmV2Web.CurrentUserView

  has_one(:user, serializer: CurrentUserView, include: true)
end
