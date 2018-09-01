defmodule StudentsCrmV2.Repo.Migrations.CreateAuthentications do
  use Ecto.Migration

  def change do
    create table(:authentications) do
      add :sub, :string

      add :user_id, references("users"), on_delete: :delete_all

      timestamps()
    end

    create index(:authentications, [:sub], unique: true)
  end
end
