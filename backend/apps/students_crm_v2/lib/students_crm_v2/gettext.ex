defmodule StudentsCrmV2.Gettext do
  @moduledoc false

  use Gettext, otp_app: :students_crm_v2

  def supported_locales do
    __MODULE__
    |> Gettext.known_locales()
    |> Enum.into(MapSet.new)
    |> MapSet.intersection(Enum.into(config()[:locales], MapSet.new))
    |> MapSet.to_list
  end

  def supported?(locale) do
    Enum.any? supported_locales, &(&1 == locale)
  end

  defp config, do: Application.get_env(:students_crm_v2, __MODULE__)
end
