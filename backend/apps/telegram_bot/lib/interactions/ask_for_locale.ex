defmodule TelegramBot.Interactions.AskForLocale do
  @moduledoc false

  alias Nadia.Model.{
    InlineKeyboardButton,
    InlineKeyboardMarkup
  }

  def execute(text, uid) do
    Nadia.send_message(
      uid,
      """
      🇺🇦 Оберіть мову будь ласка

      🇷🇺 Выберите язык пожалуйста

      🇬🇧 Please choose the language
      """,
      reply_markup: %InlineKeyboardMarkup{
        inline_keyboard: [
          [
            %InlineKeyboardButton{url: "", callback_data: encode("uk", text), text: "🇺🇦 Українська"},
            %InlineKeyboardButton{url: "", callback_data: encode("ru", text), text: "🇷🇺 Русский"},
            %InlineKeyboardButton{url: "", callback_data: encode("en", text), text: "🇬🇧 English"}
          ]
        ]
      }
    )
  end

  defp encode(locale, text) do
    Poison.encode!(%{
      "text" => text,
      "locale" => locale
    })
  end
end
