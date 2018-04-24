defmodule StudentsCrmV2.Models.Document do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.User

  @type t :: %__MODULE__{}

  schema "documents" do
    field :kind, :string

    belongs_to :user, User

    timestamps()
  end
end
