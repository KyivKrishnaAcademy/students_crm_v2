defmodule StudentsCrmV2.Models.User do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.Contact

  @type t :: %__MODULE__{}

  schema "users" do
    field(:birthday, :date)
    field(:display_name, :string)
    field(:gender, :string)
    field(:locale, :string)
    field(:privacy_agreed, :boolean)

    has_many(:contacts, Contact)

    timestamps()
  end
end
