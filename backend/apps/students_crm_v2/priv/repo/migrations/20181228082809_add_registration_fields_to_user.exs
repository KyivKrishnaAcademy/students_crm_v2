defmodule StudentsCrmV2.Repo.Migrations.AddRegistrationFieldsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:education, :string)
      add(:favorite_lectots, :string)
      add(:marital_status, :string)
      add(:middle_name, :string)
      add(:name, :string)
      add(:surname, :string)
      add(:work, :string)
    end
  end
end
