defmodule StudentsCrmV2.Interactions.AcademicGroup.Show do
  @moduledoc false

  alias StudentsCrmV2.Models.AcademicGroup
  alias StudentsCrmV2.Repo

  @spec execute(id :: term()) :: {:ok, AcademicGroup.t()} | {:error, nil} | {:error, no_return()}
  def execute(id) do
    AcademicGroup
    |> Repo.get(id)
    |> result()
  end

  defp result(academic_group = %AcademicGroup{}), do: {:ok, academic_group}
  defp result(something), do: {:error, something}
end
