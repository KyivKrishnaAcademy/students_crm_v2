defmodule StudentsCrmV2.Interactions.AcademicGroup.List do
  @moduledoc false

  alias StudentsCrmV2.Concerns.Pager
  alias StudentsCrmV2.Models.AcademicGroup

  @spec execute(params :: map()) :: {[AcademicGroup.t()] | no_return(), map()}
  def execute(params) do
    tenant_id = Map.get(params, "tenant_id")
    query = by_tenant(AcademicGroup, tenant_id)

    Pager.page(query, params)
  end

  defp by_tenant(query, tenant_id) do
    import Ecto.Query, only: [where: 3, order_by: 2]

    query
    |> where([ag], ag.tenant_id == ^tenant_id)
    |> order_by(asc: :name)
  end
end
