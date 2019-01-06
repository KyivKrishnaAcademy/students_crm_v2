defmodule StudentsCrmV2.Interactions.User.Adult do
  @moduledoc false

  alias StudentsCrmV2.Models.User

  @spec execute(date :: Date.t() | user :: User.t()) :: boolean()
  def execute(date = %Date{}), do: Timex.today() |> Timex.shift(years: -16) |> Timex.after?(date)
  def execute(%User{birthday: birthday}), do: birthday && execute(birthday)
end
