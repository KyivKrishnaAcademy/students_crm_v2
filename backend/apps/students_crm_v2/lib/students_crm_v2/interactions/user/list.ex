defmodule StudentsCrmV2.Interactions.User.List do
  @moduledoc false

  alias StudentsCrmV2.Concerns.Pager

  alias StudentsCrmV2.Models.{
    GroupParticipation,
    TenantUser,
    User
  }

  import Ecto.Query, only: [where: 3, join: 5, order_by: 2]

  @spec execute(params :: map()) :: {[User.t()] | no_return(), map()}
  def execute(params) do
    academic_group_id = Map.get(params, "academic_group_id")
    tenant_id = Map.get(params, "tenant_id")

    User
    |> by_tenant(tenant_id)
    |> by_academic_group(academic_group_id)
    |> order_by(asc: :complex_name)
    |> Pager.page(params)
  end

  defp by_tenant(query, tenant_id) do
    query
    |> join(:inner, [u], tu in TenantUser, tu.user_id == u.id)
    |> where([u, tu], tu.tenant_id == ^tenant_id)
  end

  defp by_academic_group(query, nil), do: query

  defp by_academic_group(query, academic_group_id) do
    query
    |> join(:inner, [u], gp in GroupParticipation, gp.user_id == u.id)
    |> where([u, _, gp], gp.academic_group_id == ^academic_group_id)
  end
end
