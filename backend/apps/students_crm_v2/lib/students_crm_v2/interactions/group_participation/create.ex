defmodule StudentsCrmV2.Interactions.GroupParticipation.Create do
  @moduledoc false

  alias Ecto.Changeset
  alias StudentsCrmV2.Repo

  alias StudentsCrmV2.Models.{
    GroupParticipation,
    User
  }

  @required_fields ~w[academic_group_id user_id join_time tenant_id]a

  @spec execute(params :: map(), author :: User.t()) :: {:ok, GroupParticipation.t()} | {:error, :unauthorized}
  def execute(params, author) do
    params_with_join_time = Map.put(params, "join_time", DateTime.utc_now())

    %GroupParticipation{}
    |> authorize(author)
    |> validate_n_create(params_with_join_time)
    |> preload()
  end

  defp authorize(group_participation = %GroupParticipation{}, _), do: {:ok, group_participation}

  defp validate_n_create({:ok, group_participation}, params) do
    import Changeset, only: [validate_required: 3]
    import StudentsCrmV2.Gettext, only: [gettext: 1]

    group_participation
    |> Changeset.cast(params, @required_fields)
    |> validate_required(@required_fields, message: gettext("can't be blank"))
    |> Repo.insert()
  end

  defp preload({:ok, group_participation = %GroupParticipation{}}) do
    {:ok, Repo.preload(group_participation, [:academic_group, :user])}
  end

  defp preload(anything_else), do: anything_else
end
