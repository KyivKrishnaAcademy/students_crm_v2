defmodule StudentsCrmV2.Repo.Migrations.ChangeTelegramUidType do
  use Ecto.Migration

  def up do
    alter table("phones") do
      remove :telegram_uid

      add :telegram_uid, :integer
    end

    create index(:phones, [:telegram_uid])
  end

  def down do
    alter table("phones") do
      remove :telegram_uid

      add :telegram_uid, :string
    end

    create index(:phones, [:telegram_uid])
  end
end
