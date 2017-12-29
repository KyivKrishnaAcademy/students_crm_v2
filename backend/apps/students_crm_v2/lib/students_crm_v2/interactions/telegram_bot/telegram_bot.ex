defmodule StudentsCrmV2.Interactions.TelegramBot do
  @moduledoc false

  alias StudentsCrmV2.Gettext

  alias StudentsCrmV2.Interactions.TelegramBot.{
    AskForLocale,
    Start,
  }

  def available_methods do
    ~w[
      login
    ]
  end

  def dispatch(%{"message" => %{"text" => text, "from" => %{"id" => uid}}}) do
    cached_user = cache_get(uid)

    if cached_user |> Map.get("locale") |> Gettext.supported?(),
      do: handle_message(cached_user, text),
      else: ask_for_locale(text, uid)
  end

  def dispatch(%{"callback_query" => %{"data" => serialized_data, "from" => %{"id" => user_id}}}) do
    data = Poison.decode!(serialized_data)

    cache_update(user_id, "locale", Map.get(data, "locale"))

    dispatch(%{"message" => %{"text" => Map.get(data, "text"), "from" => %{"id" => user_id}}})
  end

  def dispatch(params) do
    require Logger

    Logger.info(fn -> "Dunno how to handle telegram webhook #{inspect(params)}" end)
  end

  defp ask_for_locale(text, user_id), do: AskForLocale.execute(text, user_id)

  defp handle_message(%{"uid" => uid, "locale" => locale}, _), do: Start.execute(locale, uid)

  defp cache_get(user_id), do: ConCache.get(:crm_cache, {:telegram, user_id}) || %{}

  defp cache_update(uid, key, value) do
    ConCache.update(:crm_cache, {:telegram, uid}, &({:ok, Map.put(&1 || %{"uid" => uid}, key, value)}))
  end
end
