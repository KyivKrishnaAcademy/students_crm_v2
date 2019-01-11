defmodule StudentsCrmV2.Repo.Migrations.AddComplexNameToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:complex_name, :string)
    end
  end
end
