defmodule StudentsCrmV2.Interactions.User.GetByContact do
  @moduledoc false

  alias StudentsCrmV2.Models.{Contact, User}
  alias StudentsCrmV2.Repo

  @spec execute(id :: term()) :: {:ok, User.t()} | {:error, :no_user_found}
  def execute({type, value}) do
    import Ecto.Query, only: [where: 3, join: 5]

    User
    |> join(:inner, [u], c in Contact, c.user_id == u.id)
    |> where([u, c], c.kind == ^type and c.value == ^value)
    |> Repo.one()
    |> result()
  end

  defp result(user = %User{}), do: {:ok, user}
  defp result(_), do: {:error, :no_user_found}
end
