defmodule StudentsCrmV2.Repo.Migrations.CreateAcademicGroup do
  use Ecto.Migration

  def change do
    create table(:academic_groups) do
      add(:name, :string)
      add(:description, :string)
      add(:established_on, :date)

      timestamps()
    end

    create(index(:academic_groups, [:name], unique: true))

    create table(:academic_groups_tenants) do
      add(:academic_group_id, references(:users, on_delete: :delete_all))
      add(:tenant_id, references(:tenants, on_delete: :delete_all))

      timestamps()
    end

    create(index(:academic_groups_tenants, [:academic_group_id, :tenant_id], unique: true))
  end
end
