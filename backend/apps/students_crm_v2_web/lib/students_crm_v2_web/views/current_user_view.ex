defmodule StudentsCrmV2Web.CurrentUserView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  attributes([:birthday, :display_name, :gender, :locale, :privacy_agreed, :registered])

  def type, do: "user"

  def registered(user, _conn) do
    user.privacy_agreed && string_present(user.display_name) && string_present(user.gender) && user.birthday
  end

  defp string_present(value), do: value && String.length(value) > 0
end
