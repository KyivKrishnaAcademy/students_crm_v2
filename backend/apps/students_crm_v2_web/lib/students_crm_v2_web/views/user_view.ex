defmodule StudentsCrmV2Web.UserView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  attributes [:display_name, :locale]
end
