defmodule StudentsCrmV2.Interactions.GroupParticipation.List do
  @moduledoc false

  alias StudentsCrmV2.Repo

  alias StudentsCrmV2.Models.{
    GroupParticipation,
    User
  }

  @whitelist ~w[user_id tenant_id]

  @spec execute(params :: map(), author :: User.t()) :: [GroupParticipation.t()] | no_return()
  def execute(%{"user_id" => user_id, "tenant_id" => tenant_id}, _author) do
    import Ecto.Query, only: [where: 3]

    result = GroupParticipation
    |> where([gp], gp.user_id == ^user_id and gp.tenant_id == ^tenant_id)
    |> Repo.all()
    |> Repo.preload([:academic_group, :user])

    {:ok, result}
  end

  def execute(_, _), do: {:error, "user_id and tenant_id should be provided"}
end
