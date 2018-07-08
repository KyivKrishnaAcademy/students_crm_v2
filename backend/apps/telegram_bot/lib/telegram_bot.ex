defmodule TelegramBot do
  @moduledoc false

  alias TelegramBot.Gettext

  alias TelegramBot.Interactions.{
    AskForLocale,
    Login,
    Start
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

    :ok = cache_update(uid, "locale", Map.get(data, "locale"))

    dispatch(%{"message" => %{"text" => Map.get(data, "text"), "from" => %{"id" => uid}}})
  end

  def dispatch(%{
        "message" => %{
          "contact" => %{"phone_number" => phone_number, "user_id" => user_id},
          "from" => %{"id" => uid}
        }
      })
      when uid == user_id do
    :ok = cache_update(uid, "telegram_phone", phone_number)

    cached_user = cache_get(uid)

    if cached_user |> Map.get("locale") |> Gettext.supported?(),
      do: handle_message(cached_user, "/login"),
      else: ask_for_locale("/login", uid)
  end

  def dispatch(params) do
    require Logger

    Logger.info(fn -> "Dunno how to handle telegram webhook #{inspect(params)}" end)
  end

  def cache_get(uid), do: ConCache.get(:telegram_bot_cache, {:telegram, uid}) || set_from_db(uid) || %{"uid" => uid}

  def cache_update(uid, key, value) do
    ConCache.update(:telegram_bot_cache, {:telegram, uid}, &{:ok, Map.put(&1 || %{"uid" => uid}, key, value)})
  end

  def cache_update(uid, map) do
    ConCache.update(
      :telegram_bot_cache,
      {:telegram, uid},
      &{:ok,
       map
       |> Enum.into(&1 || %{"uid" => uid})
       |> Enum.filter(fn {_, v} -> v != nil end)
       |> Enum.into(%{})}
    )
  end

  defp ask_for_locale(text, uid), do: AskForLocale.execute(text, uid)

  defp handle_message(cached_user, "/login"), do: Login.execute(cached_user)
  defp handle_message(%{"uid" => uid, "locale" => locale}, _), do: Start.execute(locale, uid)

  defp set_from_db(uid) do
    user_data = StudentsCrmV2.show_user_for_telegram_bot(uid)

    if user_data, do: ConCache.put(:telegram_bot_cache, {:telegram, uid}, user_data)

    user_data
  end
end
