defmodule StudentsCrmV2 do
  @moduledoc """
  StudentsCrmV2 keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias StudentsCrmV2.Interactions.{
    Auth,
    Document,
    TelegramBot,
    User,
  }

  alias StudentsCrmV2.Uploaders

  defdelegate login_by_token(user_id), to: Auth.LoginByToken, as: :execute
  defdelegate create_login_token(user_id), to: Auth.CreateLoginToken, as: :execute

  defdelegate create_document(kind, file, user_id, author), to: Document.Create, as: :execute
  defdelegate show_document(id, current_user), to: Document.Show, as: :execute

  defdelegate show_user_for_telegram_bot(uid), to: TelegramBot.ShowUser, as: :execute
  defdelegate create_user_for_telegram_bot(locale, phone, uid), to: TelegramBot.CreateUser, as: :execute

  defdelegate list_users(), to: User.List, as: :execute
  defdelegate show_user(id), to: User.Show, as: :execute
  defdelegate update_user(user_id, params, author), to: User.Update, as: :execute
  defdelegate agree_to_privacy_policy(id, author), to: User.Agree, as: :execute

  defdelegate document_url(asset, version), to: Uploaders.Document, as: :url
end
