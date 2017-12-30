defmodule StudentsCrmV2.Models.Phone do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.User

  schema "phones" do
    field :phone, :string
    field :telegram_uid, :integer

    belongs_to :user, User

    timestamps()
  end
end
