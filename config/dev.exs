use Mix.Config


config :cooking_quest, CookingQuest.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  check_origin: false,
  watchers: []


# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :cooking_quest, CookingQuest.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "cooking_quest_dev",
  hostname: "localhost",
  pool_size: 10

config :cooking_quest, CookingQuest.Mailer,
  adapter: Bamboo.LocalAdapter
