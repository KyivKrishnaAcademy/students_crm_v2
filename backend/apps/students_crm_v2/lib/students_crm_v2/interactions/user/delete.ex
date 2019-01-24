defmodule StudentsCrmV2.Interactions.User.Delete do
  @moduledoc false

  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2.Repo

  @spec execute(id :: term()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def execute(id) do
    User
    |> Repo.get(id)
    |> Repo.delete()
  end
end
