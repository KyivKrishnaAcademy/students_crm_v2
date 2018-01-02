defmodule TelegramBot.Interactions.Start do
  @moduledoc false

  import TelegramBot.Gettext

  def execute(locale, uid) do
    Gettext.with_locale TelegramBot.Gettext, locale, fn ->
      hello = gettext("How can I serve you?\n")
      methods = Enum.map(
        TelegramBot.available_methods,
        &(Gettext.gettext(TelegramBot.Gettext, "telegram #{&1} - description"))
      )

      Nadia.send_message(uid, Enum.join([hello | methods], "\n"))
    end
  end
end
