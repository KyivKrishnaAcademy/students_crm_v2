defmodule StudentsCrmV2Web.CurrentUserView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  attributes [:display_name, :locale, :privacy_agreed, :registered]

  def registered(user, _conn), do: user.privacy_agreed
  def type, do: "user"
end
