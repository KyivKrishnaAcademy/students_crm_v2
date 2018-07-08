defmodule TelegramBot.Interactions.Login do
  @moduledoc false

  import TelegramBot.Gettext

  alias Nadia.Model.{KeyboardButton, ReplyKeyboardMarkup}

  @spec execute(map()) :: {:ok, map()}
  def execute(%{"uid" => uid, "locale" => locale, "telegram_phone" => phone_number}) do
    {:ok, %{id: user_id}} = StudentsCrmV2.create_user_for_telegram_bot(locale, phone_number, uid)

    :ok =
      TelegramBot.cache_update(uid, %{
        "id" => user_id,
        "phone" => phone_number,
        "telegram_phone" => nil
      })

    token = StudentsCrmV2.create_login_token(user_id)

    send_token(token, locale, uid)
  end

  def execute(%{"id" => id, "uid" => uid, "locale" => locale, "phone" => _}) do
    token = StudentsCrmV2.create_login_token(id)

    send_token(token, locale, uid)
  end

  def execute(%{"uid" => uid, "locale" => locale}) do
    Gettext.with_locale(TelegramBot.Gettext, locale, fn ->
      message = gettext("Share your phone number to register")
      button_label = gettext("Yes, send send my phone number!")

      Nadia.send_message(
        uid,
        message,
        reply_markup: %ReplyKeyboardMarkup{
          one_time_keyboard: true,
          keyboard: [[%KeyboardButton{request_contact: true, text: button_label}]]
        }
      )
    end)
  end

  @spec send_token(String.t(), String.t(), integer) :: {:ok, map()}
  defp send_token(token, locale, uid) do
    Gettext.with_locale(TelegramBot.Gettext, locale, fn ->
      message = gettext("Use this token to login: %{token}", token: token)

      Nadia.send_message(uid, message)
    end)
  end
end
