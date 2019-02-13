defmodule StudentsCrmV2.Interactions.GroupParticipation.List do
  @moduledoc false

  alias StudentsCrmV2.Repo

  alias StudentsCrmV2.Models.{
    GroupParticipation,
    User
  }

  @whitelist ~w[user_id tenant_id]

  @spec execute(params :: map(), author :: User.t()) :: [GroupParticipation.t()] | no_return()
  def execute(params, _author) do
    import Ecto.Query, only: [where: 2]

    dynamic_condition =
      params
      |> Map.take(@whitelist)
      |> Enum.reduce(nil, &dynamic_condition_reducer/2)

    GroupParticipation
    |> where(^dynamic_condition)
    |> Repo.all()
    |> Repo.preload([:academic_group, :user])
  end

  defp dynamic_condition_reducer({key, value}, acc) do
    import Ecto.Query, only: [dynamic: 2]
    import Ecto.Query.API, only: [field: 2]

    atom_key = String.to_atom(key)

    if acc do
      dynamic([q], field(q, ^atom_key) == ^value and ^acc)
    else
      dynamic([q], field(q, ^atom_key) == ^value)
    end
  end
end
