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

  def dispatch(%{"callback_query" => %{"data" => serialized_data, "from" => %{"id" => uid}}}) do
    data = Poison.decode!(serialized_data)

    cache_update(uid, "locale", Map.get(data, "locale"))

    dispatch(%{"message" => %{"text" => Map.get(data, "text"), "from" => %{"id" => uid}}})
  end

  def dispatch(params) do
    require Logger

    Logger.info(fn -> "Dunno how to handle telegram webhook #{inspect(params)}" end)
  end

  defp ask_for_locale(text, uid), do: AskForLocale.execute(text, uid)

  defp handle_message(%{"uid" => uid, "locale" => locale}, _), do: Start.execute(locale, uid)

  defp cache_get(uid), do: ConCache.get(:crm_cache, {:telegram, uid}) || %{}

  defp cache_update(uid, key, value) do
    ConCache.update(:crm_cache, {:telegram, uid}, &({:ok, Map.put(&1 || %{"uid" => uid}, key, value)}))
  end
end
