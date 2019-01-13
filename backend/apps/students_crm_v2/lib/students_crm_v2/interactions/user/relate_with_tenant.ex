defmodule StudentsCrmV2.Interactions.User.RelateWithTenant do
  @moduledoc false

  alias Ecto.Changeset
  alias StudentsCrmV2.Models.TenantUser
  alias StudentsCrmV2.Repo

  @spec execute(user_id :: term(), tenant_id :: term()) :: :ok
  def execute(user_id, tenant_id) do
    %TenantUser{tenant_id: tenant_id, user_id: user_id}
    |> Changeset.change()
    |> Changeset.unique_constraint(:tenant_id, name: "tenants_users_tenant_id_user_id_index")
    |> Repo.insert()
    |> result()
  end

  defp result({:ok, _}), do: :ok
  defp result({:error, %Changeset{errors: [tenant_id: {"has already been taken", []}]}}), do: :ok
  defp result(other), do: other
end
