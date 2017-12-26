defmodule StudentsCrmV2.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :locale, :string, size: 2

      timestamps()
    end
  end
end
