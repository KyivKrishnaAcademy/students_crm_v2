defmodule StudentsCrmV2.Interactions.TelegramBot do
  @moduledoc false

  alias StudentsCrmV2.{Repo, Gettext}

  alias StudentsCrmV2.Interactions.TelegramBot.{
    AskForLocale,
    Login,
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

  def dispatch(%{
    "message" => %{
      "contact" => %{"phone_number" => phone_number, "user_id" => user_id},
      "from" => %{"id" => uid}
    }
  }) when uid == user_id do
    cache_update(uid, "telegram_phone", phone_number)

    cached_user = cache_get(uid)

    if cached_user |> Map.get("locale") |> Gettext.supported?(),
      do: handle_message(cached_user, "/login"),
      else: ask_for_locale("/login", uid)
  end

  def dispatch(params) do
    require Logger

    Logger.info(fn -> "Dunno how to handle telegram webhook #{inspect(params)}" end)
  end

  def cache_get(uid), do: ConCache.get(:crm_cache, {:telegram, uid}) || set_from_db(uid) || %{"uid" => uid}

  def cache_update(uid, key, nil) do
    ConCache.update(:crm_cache, {:telegram, uid}, &({:ok, Map.drop(&1 || %{"uid" => uid}, [key])}))
  end

  def cache_update(uid, key, value) do
    ConCache.update(:crm_cache, {:telegram, uid}, &({:ok, Map.put(&1 || %{"uid" => uid}, key, value)}))
  end

  defp ask_for_locale(text, uid), do: AskForLocale.execute(text, uid)

  defp handle_message(cached_user, "/login"), do: Login.execute(cached_user)
  defp handle_message(%{"uid" => uid, "locale" => locale}, _), do: Start.execute(locale, uid)

  defp set_from_db(uid) do
    import Ecto.Query, only: [join: 5, where: 3, select: 3]

    user_data = "phones"
    |> join(:inner, [p], u in "users", p.user_id == u.id)
    |> where([p, u], p.telegram_uid == type(^uid, :integer))
    |> select([p, u], %{"locale" => u.locale, "phone" => p.phone, "uid" => type(^uid, :integer)})
    |> Repo.one()

    if user_data, do: ConCache.put(:crm_cache, {:telegram, uid}, user_data)

    user_data
  end
end
