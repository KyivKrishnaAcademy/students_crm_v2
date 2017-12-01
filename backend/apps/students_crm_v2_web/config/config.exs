# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :students_crm_v2_web,
  namespace: StudentsCrmV2Web,
  ecto_repos: [StudentsCrmV2.Repo]

# Configures the endpoint
config :students_crm_v2_web, StudentsCrmV2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Iy7j+9GEXPxQ8YlHGIQDLsBDUB9oFNda7wmIfl/sNBiCk97xZQFsx3MPHcPzNBaF",
  render_errors: [view: StudentsCrmV2Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StudentsCrmV2Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :students_crm_v2_web, :generators,
  context_app: :students_crm_v2

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
