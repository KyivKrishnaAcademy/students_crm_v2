defmodule StudentsCrmV2.Repo.Migrations.CreatePhone do
  use Ecto.Migration

  def change do
    create table(:phones) do
      add :phone, :string
      add :telegram_uid, :string

      add :user_id, references("users"), on_delete: :delete_all

      timestamps()
    end
  end
end
