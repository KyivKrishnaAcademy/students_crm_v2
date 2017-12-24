defmodule StudentsCrmV2.Interactions.TelegramBot.Start do
  @moduledoc false

  import StudentsCrmV2.Gettext

  alias StudentsCrmV2.Interactions.TelegramBot

  def execute(locale, user_id) do
    Gettext.with_locale StudentsCrmV2.Gettext, locale, fn ->
      hello = gettext("How can I serve you?\n")
      methods = Enum.map(
        TelegramBot.available_methods,
        &(Gettext.gettext(StudentsCrmV2.Gettext, "telegram #{&1} - description"))
      )

      Nadia.send_message(user_id, Enum.join([hello | methods], "\n"))
    end
  end
end
