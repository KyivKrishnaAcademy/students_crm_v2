defmodule StudentsCrmV2.Interactions.AcademicGroup.Create do
  @moduledoc false

  alias StudentsCrmV2.Interactions.AcademicGroup.CreateOrUpdate
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
    |> CreateOrUpdate.execute(params, author, @fields, @required_fields)
    |> Repo.insert()
  end
end
