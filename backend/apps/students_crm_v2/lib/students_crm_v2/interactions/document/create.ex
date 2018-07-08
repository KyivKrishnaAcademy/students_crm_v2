defmodule StudentsCrmV2.Interactions.Document.Create do
  @moduledoc false

  alias Ecto.Changeset
  alias StudentsCrmV2.Models.{Document, User}
  alias StudentsCrmV2.Repo

  @valid_kinds ["identification", "parents_permission"]

  @spec execute(
          kind :: String.t(),
          file :: Plug.Upload.t(),
          user_id :: integer(),
          author :: User.t()
        ) :: {:ok, Document.t()} | {:error, :unauthorized}
  def execute(kind, file, user_id, author) do
    user_id
    |> authorize(author)
    |> create_document(kind)
    |> attach_file(file)
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

  defp attach_file({:ok, document}, file) do
    document
    |> Document.attach_asset(file)
    |> Repo.update()
  end

  defp attach_file(error, _), do: error
end
