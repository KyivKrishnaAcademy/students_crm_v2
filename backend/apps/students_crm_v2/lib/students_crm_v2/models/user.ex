defmodule StudentsCrmV2.Models.User do
  @moduledoc false

  use Ecto.Schema

  schema "users" do
    field :email, :string

    timestamps()
  end
end
