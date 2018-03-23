defmodule StudentsCrmV2.Repo.Migrations.AddPrivacyAgreementAcceptanceToUser do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :privacy_agreed, :boolean, default: false
    end
  end

  def down do
    alter table(:users) do
      remove :privacy_agreed
    end
  end
end
