defmodule StudentsCrmV2.Repo.Migrations.DropPhone do
  use Ecto.Migration

  def change do
    drop(table(:phones))
  end
end
