defmodule StudentsCrmV2.Interactions.Document.Create do
  @moduledoc false

  alias StudentsCrmV2.Repo
  alias StudentsCrmV2.Models.{Document, User}
  alias Ecto.Changeset

  @valid_kinds ["identification", "parents_permission"]

  @spec execute(
    kind :: String.t(),
    user_id :: String.t(),
    author :: User.t()
  ) :: {:ok, Document.t()} | {:error, :unauthorized}
  def execute(kind, user_id, author) do
    user_id
    |> String.to_integer
    |> authorize(author)
    |> create_document(kind)
  end

  defp authorize(user_id, user = %User{id: author_id}) when user_id == author_id, do: {:ok, user}
  defp authorize(_, _), do: {:error, :unauthorized}

  defp create_document({:ok, user}, kind) do
    %Document{user: user}
    |> Changeset.change(kind: kind)
    |> Changeset.validate_inclusion(:kind, @valid_kinds)
    |> Repo.insert()
  end

  defp create_document(error, _), do: error
end
