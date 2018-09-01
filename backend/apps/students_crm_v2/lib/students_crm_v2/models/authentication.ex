defmodule StudentsCrmV2.Models.Authentication do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.User

  @type t :: %__MODULE__{}

  schema "authentications" do
    field(:sub, :string)

    belongs_to(:user, User)

    timestamps()
  end
end
