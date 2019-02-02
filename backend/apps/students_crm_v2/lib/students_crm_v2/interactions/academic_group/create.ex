defmodule StudentsCrmV2.Interactions.AcademicGroup.Create do
  @moduledoc false

  alias Ecto.Changeset
  alias StudentsCrmV2.Repo

  alias StudentsCrmV2.Models.{
    AcademicGroup,
    User
  }

  @fields ~w[name established_on tenant_id description]a
  @required_fields ~w[name established_on tenant_id]a

  @spec execute(params :: map(), author :: User.t()) :: {:ok, AcademicGroup.t()} | {:error, :unauthorized}
  def execute(params, author) do
    %AcademicGroup{}
    |> authorize(author)
    |> create_group(params)
  end

  defp authorize(group = %AcademicGroup{}, _), do: {:ok, group}

  defp create_group({:ok, group}, params), do: group |> Changeset.cast(params, @fields) |> validate |> Repo.insert()
  # defp create_group(error, _), do: error

  defp validate(changeset) do
    import Changeset, only: [validate_required: 3, unique_constraint: 3]
    import StudentsCrmV2.Gettext, only: [gettext: 1]

    changeset
    |> unique_constraint(:name, name: "academic_groups_name_tenant_id_index", message: gettext("is not unique"))
    |> validate_required(@required_fields, message: gettext("can't be blank"))
  end
end
