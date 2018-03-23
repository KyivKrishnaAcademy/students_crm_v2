defmodule StudentsCrmV2Web.CurrentUserView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  attributes [:locale, :privacy_agreed]

  def type, do: "user"
end
