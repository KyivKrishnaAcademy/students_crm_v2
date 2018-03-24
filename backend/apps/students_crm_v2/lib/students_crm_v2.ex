defmodule StudentsCrmV2 do
  @moduledoc """
  StudentsCrmV2 keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias StudentsCrmV2.Interactions.{
    Auth,
    TelegramBot,
    User,
  }

  defdelegate login_by_token(user_id), to: Auth.LoginByToken, as: :execute
  defdelegate create_login_token(user_id), to: Auth.CreateLoginToken, as: :execute

  defdelegate show_user_for_telegram_bot(uid), to: TelegramBot.ShowUser, as: :execute
  defdelegate create_user_for_telegram_bot(locale, phone, uid), to: TelegramBot.CreateUser, as: :execute

  defdelegate list_users(), to: User.List, as: :execute
  defdelegate show_user(id), to: User.Show, as: :execute
  defdelegate agree_to_privacy_policy(id, author), to: User.Agree, as: :execute
end
