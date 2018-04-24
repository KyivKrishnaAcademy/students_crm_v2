defmodule StudentsCrmV2.Interactions.Document.Show do
  @moduledoc false

  alias StudentsCrmV2.Repo
  alias StudentsCrmV2.Models.{Document, User}

  @spec execute(id :: term(), current_user :: User.t()) :: {:ok, Document.t()} | {:error, :unauthorized}
  def execute(id, current_user) do
    Document
    |> Repo.get!(id)
    |> Repo.preload(:user)
    |> authorize(current_user)
  end

  defp authorize(document = %Document{user_id: user_id}, %User{id: current_user_id}) when user_id == current_user_id,
    do: {:ok, document}
  defp authorize(_, _), do: {:error, :unauthorized}
end
