defmodule StudentsCrmV2.Repo.Migrations.AddUniqNameIndexToTenant do
  use Ecto.Migration

  def change do
    create(index(:tenants, [:name], unique: true))
  end
end
