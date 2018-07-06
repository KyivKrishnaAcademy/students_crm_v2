use Mix.Config

config :arc,
  storage: Arc.Storage.Local

config :students_crm_v2, ecto_repos: [StudentsCrmV2.Repo]

import_config "#{Mix.env}.exs"
