defmodule StudentsCrmV2.Interactions.TelegramBot.CreateUser do
  @moduledoc false

  alias StudentsCrmV2.Repo
  alias StudentsCrmV2.Models.{User, Phone}

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
