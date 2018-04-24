defmodule StudentsCrmV2Web.DocumentView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  alias StudentsCrmV2Web.UserView

  attributes [:kind]

  has_one :user, serializer: UserView, include: false
end
