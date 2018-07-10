defmodule StudentsCrmV2.Models.Document do
  @moduledoc false

  use Ecto.Schema
  use Arc.Ecto.Schema

  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2.Uploaders.Document

  @type t :: %__MODULE__{}

  schema "documents" do
    field(:kind, :string)
    field(:asset, Document.Type)

    belongs_to(:user, User)

    timestamps()
  end

  @spec attach_asset(changeset :: Ecto.Changeset.t(), asset :: Plug.Upload.t()) :: Ecto.Changeset.t() | no_return()
  @dialyzer {:nowarn_function, attach_asset: 2}
  def attach_asset(changeset, asset), do: cast_attachments(changeset, %{asset: asset}, [:asset])
end
