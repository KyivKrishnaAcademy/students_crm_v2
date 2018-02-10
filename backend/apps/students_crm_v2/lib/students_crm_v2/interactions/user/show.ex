defmodule StudentsCrmV2.Interactions.User.Show do
  @moduledoc false

  alias StudentsCrmV2.Repo
  alias StudentsCrmV2.Models.User

  @spec execute(id :: term()) :: User.t() | nil | no_return()
  def execute(id) do
    Repo.get(User, id)
  end
end
