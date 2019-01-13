defmodule StudentsCrmV2.Interactions.User.List do
  @moduledoc false

  alias StudentsCrmV2.Repo

  alias StudentsCrmV2.Models.{
    TenantUser,
    User
  }

  @spec execute(params :: map()) :: {[User.t()] | no_return(), map()}
  def execute(params) do
    page_number = page_param(params, "number", "1")
    page_size = page_param(params, "size", "50")
    tenant_id = Map.get(params, "tenant_id")
    query = by_tenant(User, tenant_id)

    {page(query, page_number, page_size), %{total: count(query)}}
  end

  defp by_tenant(query, tenant_id) do
    import Ecto.Query, only: [where: 3, join: 5]

    query
    |> join(:inner, [u], tu in TenantUser, tu.user_id == u.id)
    |> where([u, tu], tu.tenant_id == ^tenant_id)
  end

  defp page(query, page_number, page_size) do
    import Ecto.Query, only: [limit: 2, offset: 2]

    offset = page_size * (page_number - 1)

    query
    |> limit(^page_size)
    |> offset(^offset)
    |> Repo.all()
  end

  defp page_param(params, name, default), do: String.to_integer(get_in(params, ["page", name]) || default)

  defp count(query), do: Repo.aggregate(query, :count, :id) || 0
end
