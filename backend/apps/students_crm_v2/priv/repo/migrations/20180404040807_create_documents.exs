defmodule StudentsCrmV2.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :kind, :string
      add :asset, :string

      add :user_id, references("users"), on_delete: :delete_all

      timestamps()
    end
  end
end
