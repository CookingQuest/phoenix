use Mix.Config


config :cooking_quest, CookingQuest.Mailer,
  adapter: Bamboo.SendgridAdapter,
  api_key: "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"




config :cooking_quest, CookingQuest.Endpoint,
  http: [port: 4000],
  url: [host: "cookingquests.com", port: 80],
  server: true,
  secret_key_base: "${SECRET_KEY_BASE}"

# config :logger, level: :info

# Configure your database
config :cooking_quest, CookingQuest.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: "postgres",
  username: "${POSTGRES_USER}",
  password: "${POSTGRES_PASSWORD}",
  database: "${POSTGRES_DB_NAME}",
  pool_size: 20
