defmodule StudentsCrmV2.Interactions.TelegramBot.Login do
  @moduledoc false

  import StudentsCrmV2.Gettext

  alias Nadia.Model.{KeyboardButton, ReplyKeyboardMarkup}
  alias StudentsCrmV2.Repo
  alias StudentsCrmV2.Models.{User, Phone}
  alias StudentsCrmV2.Interactions.TelegramBot

  def execute(%{"uid" => uid, "locale" => locale, "telegram_phone" => phone_number}) do
    Repo.insert(%User{
      locale: locale,
      phones: [
        %Phone{
          phone: phone_number,
          telegram_uid: uid,
        }
      ],
    })

    TelegramBot.cache_update(uid, "phone", phone_number)
    TelegramBot.cache_update(uid, "telegram_phone", nil)

    Gettext.with_locale StudentsCrmV2.Gettext, locale, fn ->
      message = gettext("will register")

      Nadia.send_message(uid, message)
    end
  end

  def execute(%{"uid" => uid, "locale" => locale, "phone" => phone_number}) do
    Gettext.with_locale StudentsCrmV2.Gettext, locale, fn ->
      message = gettext("will login")

      Nadia.send_message(uid, message)
    end
  end

  def execute(%{"uid" => uid, "locale" => locale}) do
    Gettext.with_locale StudentsCrmV2.Gettext, locale, fn ->
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
