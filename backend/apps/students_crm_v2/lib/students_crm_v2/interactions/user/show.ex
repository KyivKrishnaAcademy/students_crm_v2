defmodule StudentsCrmV2.Interactions.User.Show do
  @moduledoc false

  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2.Repo

  @spec execute(id :: term()) :: {:ok, User.t()} | {:error, nil} | {:error, no_return()}
  def execute(id) do
    User
    |> Repo.get(id)
    |> result()
  end

  defp result(user = %User{}), do: {:ok, user}
  defp result(nil), do: {:error, :not_found}
  defp result(something), do: {:error, something}
end
