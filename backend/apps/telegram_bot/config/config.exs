use Mix.Config

config :telegram_bot, TelegramBot.Gettext,
  locales: ~w(en uk ru),
  default_locale: "uk"
