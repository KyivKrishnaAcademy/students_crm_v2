defmodule StudentsCrmV2.Models.Contact do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.User

  @type t :: %__MODULE__{}

  schema "contacts" do
    field(:kind, :string)
    field(:value, :string)
    field(:verified, :boolean)

    belongs_to(:user, User)

    timestamps()
  end
end
