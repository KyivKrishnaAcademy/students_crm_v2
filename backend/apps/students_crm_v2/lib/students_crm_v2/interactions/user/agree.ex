defmodule StudentsCrmV2.Interactions.User.Agree do
  @moduledoc false

  alias Ecto.Changeset
  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2.Repo

  @spec execute(id :: String.t(), author :: User.t()) :: {:ok, User.t()} | {:error, :unauthorized}
  def execute(id, author) do
    id
    |> String.to_integer()
    |> authorize(author)
    |> agree_to_privacy
  end

  defp authorize(user_id, user = %User{id: author_id}) when user_id == author_id, do: {:ok, user}
  defp authorize(_, _), do: {:error, :unauthorized}

  defp agree_to_privacy({:ok, user}), do: user |> Changeset.change(privacy_agreed: true) |> Repo.update()
  defp agree_to_privacy(error), do: error
end
