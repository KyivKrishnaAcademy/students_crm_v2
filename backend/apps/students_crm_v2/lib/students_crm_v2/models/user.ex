defmodule StudentsCrmV2.Models.User do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.Phone

  @type t :: %__MODULE__{}

  schema "users" do
    field :display_name, :string
    field :locale, :string
    field :privacy_agreed, :boolean

    has_many :phones, Phone

    timestamps()
  end
end
