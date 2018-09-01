defmodule StudentsCrmV2.Interactions.User.Register do
  @moduledoc false

  alias StudentsCrmV2.Repo

  alias StudentsCrmV2.Models.{
    Authentication,
    User
  }

  @spec execute(id :: map) :: {:ok, User.t()} | nil | no_return()
  def execute(%{"name" => display_name, "sub" => sub}) do
    Repo.insert(%User{display_name: display_name, authentications: [%Authentication{sub: sub}]})
  end
end
