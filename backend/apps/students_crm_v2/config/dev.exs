use Mix.Config

# Configure your database
config :students_crm_v2, StudentsCrmV2.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "students_crm_v2_dev",
  hostname: "localhost",
  pool_size: 10
