defmodule StudentsCrmV2 do
  @moduledoc """
  StudentsCrmV2 keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias StudentsCrmV2.Interactions

  defdelegate create_login_token(user_id), to: Interactions.CreateLoginToken, as: :execute

  defdelegate show_user_for_telegram_bot(uid), to: Interactions.TelegramBot.ShowUser, as: :execute
  defdelegate create_user_for_telegram_bot(locale, phone, uid), to: Interactions.TelegramBot.CreateUser, as: :execute

  defdelegate list_users(), to: Interactions.User.List, as: :execute
end
