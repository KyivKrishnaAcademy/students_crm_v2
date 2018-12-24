defmodule StudentsCrmV2.Interactions.Tenant.List do
  @moduledoc false

  alias StudentsCrmV2.Models.Tenant
  alias StudentsCrmV2.Repo

  @spec execute() :: [Tenant.t()] | no_return()
  def execute do
    Repo.all(Tenant)
  end
end
