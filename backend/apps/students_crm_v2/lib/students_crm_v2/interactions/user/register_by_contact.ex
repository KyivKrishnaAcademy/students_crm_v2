defmodule StudentsCrmV2.Interactions.User.RegisterByContact do
  @moduledoc false

  alias StudentsCrmV2.Models.{Contact, User}
  alias StudentsCrmV2.Repo

  @spec execute(id :: term()) :: {:ok, User.t()} | nil | no_return()
  def execute({kind, value}) do
    Repo.insert(%User{contacts: [%Contact{kind: kind, value: value}]})
  end
end
