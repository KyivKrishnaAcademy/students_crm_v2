defmodule StudentsCrmV2.Interactions.GroupParticipation.Delete do
  @moduledoc false

  alias StudentsCrmV2.Models.GroupParticipation
  alias StudentsCrmV2.Repo

  @spec execute(id :: term()) :: {:ok, GroupParticipation.t()} | {:error, Ecto.Changeset.t()}
  def execute(id) do
    GroupParticipation
    |> Repo.get(id)
    |> Repo.delete()
  end
end
