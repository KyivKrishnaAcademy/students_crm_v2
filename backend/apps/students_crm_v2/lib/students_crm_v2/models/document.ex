defmodule StudentsCrmV2.Models.Document do
  @moduledoc false

  use Ecto.Schema
  use Arc.Ecto.Schema

  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2.Uploaders.Document

  @type t :: %__MODULE__{}

  schema "documents" do
    field :kind, :string
    field :asset, Document.Type

    belongs_to :user, User

    timestamps()
  end

  def attach_asset(changeset, asset) do
    cast_attachments(changeset, %{asset: asset}, [:asset])
  end
end
