defmodule StudentsCrmV2.Models.User do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.Phone

  schema "users" do
    field :locale, :string

    has_many :phones, Phone

    timestamps()
  end
end
