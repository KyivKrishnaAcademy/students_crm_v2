defmodule StudentsCrmV2.Models.Tenant do
  @moduledoc false

  use Ecto.Schema

  @type t :: %__MODULE__{}

  schema "tenants" do
    field(:name, :string)

    timestamps()
  end
end
