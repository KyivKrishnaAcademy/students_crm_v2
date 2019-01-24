defmodule StudentsCrmV2.Models.User do
  @moduledoc false

  use Ecto.Schema

  alias StudentsCrmV2.Models.{
    Contact,
    Tenant
  }

  @type t :: %__MODULE__{}

  @genders ~w[male female]
  @marital_statuses ~w[single in_relationship married divorced widowed]

  schema "users" do
    field(:privacy_agreed, :boolean)

    field(:birthday, :date)

    field(:complex_name, :string)
    field(:display_name, :string)
    field(:education, :string)
    field(:favorite_lectots, :string)
    field(:gender, :string)
    field(:locale, :string)
    field(:marital_status, :string)
    field(:middle_name, :string)
    field(:name, :string)
    field(:surname, :string)
    field(:work, :string)

    has_many(:contacts, Contact, on_delete: :delete_all)

    many_to_many(:tenants, Tenant, join_through: "tenants_users")

    timestamps()
  end

  def genders, do: @genders
  def marital_statuses, do: @marital_statuses
end
