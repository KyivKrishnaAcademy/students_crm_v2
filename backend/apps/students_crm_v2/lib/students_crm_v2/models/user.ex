defmodule StudentsCrmV2.Models.User do
  @moduledoc false

  use Ecto.Schema

  @type t :: %__MODULE__{}

  schema "users" do
    field(:birthday, :date)
    field(:display_name, :string)
    field(:gender, :string)
    field(:locale, :string)
    field(:privacy_agreed, :boolean)

    timestamps()
  end
end
