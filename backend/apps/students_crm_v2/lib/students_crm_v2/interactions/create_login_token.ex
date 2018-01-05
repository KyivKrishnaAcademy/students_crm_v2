defmodule StudentsCrmV2.Interactions.CreateLoginToken do
  @moduledoc false

  def execute(user_id) do
    insert_new(:new, user_id)
  end

  defp insert_new(:new, user_id) do
    new_token = 5 |> :crypto.strong_rand_bytes() |> Base.url_encode64(padding: false)

    :login_tokens |> ConCache.insert_new(new_token, user_id) |> insert_new(new_token, user_id)
  end

  defp insert_new({:error, :already_exists}, _, user_id), do: insert_new(:new, user_id)
  defp insert_new(:ok, token, _), do: token
  defp insert_new(error, _, _), do: {:error, error}
end
