defmodule StudentsCrmV2Web.UserView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  attributes [:locale]
end
