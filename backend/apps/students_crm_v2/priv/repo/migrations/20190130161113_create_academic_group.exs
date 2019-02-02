defmodule StudentsCrmV2.Repo.Migrations.CreateAcademicGroup do
  use Ecto.Migration

  def change do
    create table(:academic_groups) do
      add(:name, :string)
      add(:description, :string)
      add(:established_on, :date)

      add(:tenant_id, references(:tenants, on_delete: :nothing))

      timestamps()
    end

    create(index(:academic_groups, [:name, :tenant_id], unique: true))
  end
end
