defmodule StudentsCrmV2.Repo.Migrations.CreatePhone do
  use Ecto.Migration

  def change do
    create table(:phones) do
      add(:phone, :string, null: false)
      add(:telegram_uid, :string)

      add(:user_id, references("users"), on_delete: :delete_all)

      timestamps()
    end

    create(index(:phones, [:phone], unique: true))
    create(index(:phones, [:telegram_uid]))
  end
end
