defmodule StudentsCrmV2.Repo.Migrations.CreateGroupParticipation do
  use Ecto.Migration

  def change do
    create table(:group_participations) do
      add(:join_time, :utc_datetime)
      add(:leave_reason, :string)
      add(:leave_time, :utc_datetime)

      add(:academic_group_id, references(:academic_groups, on_delete: :delete_all))
      add(:tenant_id, references(:tenants, on_delete: :delete_all))
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps()
    end
  end
end
