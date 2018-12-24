defmodule StudentsCrmV2.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add(:kind, :string)
      add(:value, :string)
      add(:verified, :boolean, default: false)

      add(:user_id, references("users"), on_delete: :delete_all)

      timestamps()
    end

    create(index(:contacts, [:kind, :value], unique: true))
  end
end
