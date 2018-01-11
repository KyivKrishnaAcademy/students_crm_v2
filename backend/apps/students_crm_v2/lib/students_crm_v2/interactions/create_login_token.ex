defmodule StudentsCrmV2.Interactions.CreateLoginToken do
  @moduledoc false

  @spec execute(integer) :: String.t()
  def execute(user_id) do
    insert_new(user_id)
  end

  @spec insert_new(integer) :: String.t()
  defp insert_new(user_id) do
    new_token = 5 |> :crypto.strong_rand_bytes() |> Base.url_encode64(padding: false)

    :login_tokens |> ConCache.insert_new(new_token, user_id) |> handle_insertion(new_token, user_id)
  end

  @spec handle_insertion(:ok | {:error, :already_exists}, String.t(), integer) :: String.t()
  defp handle_insertion(:ok, token, _), do: token
  defp handle_insertion({:error, :already_exists}, _, user_id), do: insert_new(user_id)
end
