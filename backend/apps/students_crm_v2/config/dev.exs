use Mix.Config

# Configure your database
config :students_crm_v2, StudentsCrmV2.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "students_crm_v2_dev",
  pool_size: 10
