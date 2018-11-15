defmodule StudentsCrmV2.Repo.Migrations.DropAuthentication do
  use Ecto.Migration

  def change do
    drop table(:authentications)
  end
end
