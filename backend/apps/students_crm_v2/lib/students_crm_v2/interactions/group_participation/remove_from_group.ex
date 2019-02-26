defmodule StudentsCrmV2.Interactions.GroupParticipation.RemoveFromGroup do
  @moduledoc false

  alias Ecto.Changeset
  alias StudentsCrmV2.Repo

  alias StudentsCrmV2.Models.{
    GroupParticipation,
    User
  }

  @spec execute(id :: String.t(), author :: User.t()) :: {:ok, GroupParticipation.t()} | {:error, :unauthorized}
  def execute(id, author) do
    GroupParticipation
    |> Repo.get!(id)
    |> authorize(author)
    |> remove_from_group()
  end

  defp authorize(group_participation = %GroupParticipation{}, %User{}), do: {:ok, group_participation}
  defp authorize(_, _), do: {:error, :unauthorized}

  defp remove_from_group({:ok, group_participation}) do
    import Changeset, only: [validate_inclusion: 3]

    group_participation
    |> Changeset.change(%{leave_reason: "manual", leave_time: DateTime.utc_now()})
    |> validate_inclusion(:leave_reason, GroupParticipation.leave_reasons())
    |> Repo.update()
    |> preload()
  end

  defp remove_from_group(error), do: error

  defp preload({:ok, group_participation}), do: {:ok, Repo.preload(group_participation, [:academic_group, :user])}
  defp preload(error), do: error
end
