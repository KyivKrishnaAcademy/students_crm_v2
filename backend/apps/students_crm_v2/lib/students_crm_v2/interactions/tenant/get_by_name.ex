defmodule StudentsCrmV2.Interactions.Tenant.GetByName do
  @moduledoc false

  alias StudentsCrmV2.Models.Tenant
  alias StudentsCrmV2.Repo

  @spec execute(id :: term()) :: {:ok, Tenant.t()} | {:error, :no_tenant_found}
  def execute(name) do
    import Ecto.Query, only: [where: 3]

    Tenant
    |> where([t], t.name == ^name)
    |> Repo.one()
    |> result()
  end

  defp result(tenant = %Tenant{}), do: {:ok, tenant}
  defp result(_), do: {:error, :no_tenant_found}
end
