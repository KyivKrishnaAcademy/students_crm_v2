defmodule LoginTokenCacheTest do
  use ExUnit.Case
  doctest LoginTokenCache

  test "generate" do
    assert LoginTokenCache.generate("ololo") =~ ~r/\w{5}/
  end

  test "get" do
    value = "ololo"
    key = LoginTokenCache.generate(value)

    assert LoginTokenCache.get(key) == {:ok, value}
    assert LoginTokenCache.get(key) == {:error, :no_token_found}
  end
end
