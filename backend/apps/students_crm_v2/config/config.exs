use Mix.Config

config :students_crm_v2, ecto_repos: [StudentsCrmV2.Repo]

import_config "#{Mix.env}.exs"
