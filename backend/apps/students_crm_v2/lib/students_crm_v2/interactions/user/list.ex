defmodule StudentsCrmV2.Interactions.User.List do
  @moduledoc false

  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2.Repo

  @spec execute() :: [User.t()] | no_return()
  def execute do
    Repo.all(User)
  end
end
