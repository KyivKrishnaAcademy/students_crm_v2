defmodule StudentsCrmV2.Interactions.User.Update do
  @moduledoc false

  alias StudentsCrmV2.Repo
  alias StudentsCrmV2.Models.User
  alias Ecto.Changeset

  @fields ~w(display_name)

  @spec execute(id :: String.t(), params :: map(),author :: User.t()) :: {:ok, User.t()} | {:error, :unauthorized}
  def execute(id, params, author) do
    id
    |> String.to_integer
    |> authorize(author)
    |> update_user(params)
  end

  defp authorize(user_id, user = %User{id: author_id}) when user_id == author_id, do: {:ok, user}
  defp authorize(_, _), do: {:error, :unauthorized}

  defp update_user({:ok, user}, params),
    do: user |> Changeset.cast(params, @fields) |> Changeset.validate_required([:display_name]) |> Repo.update
  defp update_user(error, _), do: error
end
