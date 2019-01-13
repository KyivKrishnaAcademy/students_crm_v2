defmodule StudentsCrmV2.Repo.Migrations.AddTenantRelationToUser do
  use Ecto.Migration

  def change do
    create table(:tenants_users) do
      add(:tenant_id, references(:tenants, on_delete: :delete_all))
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps()
    end

    create(index(:tenants_users, [:tenant_id, :user_id], unique: true))
  end
end
