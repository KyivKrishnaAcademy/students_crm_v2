use Mix.Config

# Configure your database
config :students_crm_v2, StudentsCrmV2.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "students_crm_v2_test",
  pool: Ecto.Adapters.SQL.Sandbox
