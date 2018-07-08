defmodule StudentsCrmV2.Interactions.TelegramBot.CreateUser do
  @moduledoc false

  alias StudentsCrmV2.Models.{
    Phone,
    User,
  }
  alias StudentsCrmV2.Repo

  def execute(locale, phone_number, uid) do
    Repo.insert(%User{
      locale: locale,
      phones: [
        %Phone{
          phone: phone_number,
          telegram_uid: uid,
        }
      ],
    })
  end
end
