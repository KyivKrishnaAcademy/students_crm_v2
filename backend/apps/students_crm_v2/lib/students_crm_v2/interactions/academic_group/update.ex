defmodule StudentsCrmV2.Interactions.AcademicGroup.Update do
  @moduledoc false

  alias StudentsCrmV2.Interactions.AcademicGroup.CreateOrUpdate
  alias StudentsCrmV2.Repo

  alias StudentsCrmV2.Models.{
    AcademicGroup,
    User
  }

  @fields ~w[name established_on description]a
  @required_fields ~w[name established_on]a

  @spec execute(id :: term(), params :: map(), author :: User.t()) :: {:ok, AcademicGroup.t()} | {:error, :unauthorized}
  def execute(id, params, author) do
    AcademicGroup
    |> Repo.get!(id)
    |> CreateOrUpdate.execute(params, author, @fields, @required_fields)
    |> Repo.update()
  end
end
