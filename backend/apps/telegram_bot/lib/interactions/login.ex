defmodule TelegramBot.Interactions.Login do
  @moduledoc false

  import TelegramBot.Gettext

  alias Nadia.Model.{KeyboardButton, ReplyKeyboardMarkup}

  def execute(%{"uid" => uid, "locale" => locale, "telegram_phone" => phone_number}) do
    StudentsCrmV2.create_user_for_telegram_bot(locale, phone_number, uid)

    TelegramBot.cache_update(uid, "phone", phone_number)
    TelegramBot.cache_update(uid, "telegram_phone", nil)

    Gettext.with_locale TelegramBot.Gettext, locale, fn ->
      message = gettext("will register")

      Nadia.send_message(uid, message)
    end
  end

  def execute(%{"uid" => uid, "locale" => locale, "phone" => phone_number}) do
    Gettext.with_locale TelegramBot.Gettext, locale, fn ->
      message = gettext("will login")

      Nadia.send_message(uid, message)
    end
  end

  def execute(%{"uid" => uid, "locale" => locale}) do
    Gettext.with_locale TelegramBot.Gettext, locale, fn ->
      # message = gettext("Looks like you are not registered yet. Share your phone by clicking the button")
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
    end
  end
end
