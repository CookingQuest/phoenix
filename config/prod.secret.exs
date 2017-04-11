use Mix.Config


config :cooking_quest, CookingQuest.Endpoint,
  secret_key_base: System.get_env("secret_key_base")

# Configure your database
config :cooking_quest, CookingQuest.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: "cooking_quest_prod",
  pool_size: 20
