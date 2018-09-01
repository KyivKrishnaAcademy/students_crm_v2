defmodule StudentsCrmV2.Interactions.User.Show do
  @moduledoc false

  alias StudentsCrmV2.Repo

  alias StudentsCrmV2.Models.{
    Authentication,
    User
  }

  @spec execute(id :: term()) :: User.t() | nil | no_return()
  def execute(%{"authentication_sub" => sub}) do
    import Ecto.Query, only: [join: 5, where: 3]

    User
    |> join(:inner, [u], a in Authentication, a.user_id == u.id)
    |> where([_u, a], a.sub == ^sub)
    |> Repo.one()
  end
end
