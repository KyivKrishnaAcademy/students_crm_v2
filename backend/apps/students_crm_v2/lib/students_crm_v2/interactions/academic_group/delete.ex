defmodule StudentsCrmV2.Interactions.AcademicGroup.Delete do
  @moduledoc false

  alias StudentsCrmV2.Models.AcademicGroup
  alias StudentsCrmV2.Repo

  @spec execute(id :: term()) :: {:ok, AcademicGroup.t()} | {:error, Ecto.Changeset.t()}
  def execute(id) do
    AcademicGroup
    |> Repo.get(id)
    |> Repo.delete()
  end
end
