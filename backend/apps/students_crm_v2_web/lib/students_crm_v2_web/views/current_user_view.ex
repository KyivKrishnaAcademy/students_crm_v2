defmodule StudentsCrmV2Web.CurrentUserView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  attributes([
    :birthday,
    :display_name,
    :education,
    :favorite_lectots,
    :gender,
    :locale,
    :marital_status,
    :middle_name,
    :name,
    :privacy_agreed,
    :registered,
    :surname,
    :work
  ])

  def type, do: "user"

  def registered(user, _conn) do
    Enum.all?(
      ~w[gender name surname]a,
      &(user |> Map.get(&1) |> string_present?())
    ) && user.privacy_agreed && StudentsCrmV2.adult?(user)
  end

  defp string_present?(value), do: value && String.length(value) > 0
end
