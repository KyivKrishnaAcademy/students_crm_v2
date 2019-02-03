defmodule StudentsCrmV2.Interactions.User.List do
  @moduledoc false

  alias StudentsCrmV2.Concerns.Pager

  alias StudentsCrmV2.Models.{
    TenantUser,
    User
  }

  @spec execute(params :: map()) :: {[User.t()] | no_return(), map()}
  def execute(params) do
    tenant_id = Map.get(params, "tenant_id")
    query = by_tenant(User, tenant_id)

    Pager.page(query, params)
  end

  defp by_tenant(query, tenant_id) do
    import Ecto.Query, only: [where: 3, join: 5, order_by: 2]

    query
    |> join(:inner, [u], tu in TenantUser, tu.user_id == u.id)
    |> where([u, tu], tu.tenant_id == ^tenant_id)
    |> order_by(asc: :complex_name)
  end
end
