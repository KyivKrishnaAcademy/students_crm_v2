defmodule StudentsCrmV2.Interactions.User.List do
  @moduledoc false

  alias StudentsCrmV2.Repo
  alias StudentsCrmV2.Models.User

  @spec execute() :: User.t()
  def execute do
    Repo.all(User)
  end
end
