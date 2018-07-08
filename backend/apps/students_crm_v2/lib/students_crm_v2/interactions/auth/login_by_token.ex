defmodule StudentsCrmV2.Interactions.Auth.LoginByToken do
  @moduledoc false

  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2.Repo

  @spec execute(token :: String.t()) :: User.t() | nil
  def execute(token) do
    with  user_id <- ConCache.get(:login_tokens, token),
          :ok <- ConCache.delete(:login_tokens, token),
          user <- Repo.get(User, user_id || 0)
    do
      user
    else
      _ -> nil
    end
  end
end
