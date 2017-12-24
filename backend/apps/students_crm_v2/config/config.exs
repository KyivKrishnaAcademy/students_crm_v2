use Mix.Config

config :students_crm_v2, ecto_repos: [StudentsCrmV2.Repo]

config :students_crm_v2, StudentsCrmV2.Gettext,
  locales: ~w(en uk ru),
  default_locale: "uk"

import_config "#{Mix.env}.exs"
