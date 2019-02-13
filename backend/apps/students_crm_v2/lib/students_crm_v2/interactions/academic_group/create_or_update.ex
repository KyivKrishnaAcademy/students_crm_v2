defmodule StudentsCrmV2.Interactions.AcademicGroup.CreateOrUpdate do
  @moduledoc false

  alias Ecto.Changeset

  alias StudentsCrmV2.Models.{
    AcademicGroup,
    User
  }

  @spec execute(
          model :: AcademicGroup.t(),
          params :: map(),
          author :: User.t(),
          fields :: [term()],
          required_fields :: [term()]
        ) :: {:ok, AcademicGroup.t()} | {:error, :unauthorized}
  def execute(model, params, author, fields, required_fields) do
    model
    |> authorize(author)
    |> cast_and_validate(params, fields, required_fields)
  end

  defp authorize(group = %AcademicGroup{}, _), do: {:ok, group}

  defp cast_and_validate({:ok, group}, params, fields, required_fields),
    do: group |> Changeset.cast(params, fields) |> validate(required_fields)

  # defp create_group(error, _, _, _), do: error

  defp validate(changeset, required_fields) do
    import Changeset, only: [validate_required: 3, unique_constraint: 3]
    import StudentsCrmV2.Gettext, only: [gettext: 1]

    changeset
    |> unique_constraint(:name, name: "academic_groups_name_tenant_id_index", message: gettext("is not unique"))
    |> validate_required(required_fields, message: gettext("can't be blank"))
  end
end
