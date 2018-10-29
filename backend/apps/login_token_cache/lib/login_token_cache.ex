defmodule LoginTokenCache do
  @moduledoc false

  def get(key) do
    value = ConCache.get(:login_token_cache, key)

    ConCache.delete(:login_token_cache, key)

    value
  end

  def generate(value) do
    generate(value, 1)
  end

  defp generate(value, seq_number) do
    key = random_string(5 + div(seq_number, 5))

    case ConCache.insert_new(:login_token_cache, key, value) do
      :ok -> key
      {:error, :already_exists} -> generate(value, seq_number + 1)
    end
  end

  defp random_string(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.encode32()
    |> binary_part(0, length)
  end
end
