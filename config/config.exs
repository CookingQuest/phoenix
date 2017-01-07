# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cooking_quest,
  ecto_repos: [CookingQuest.Repo]

# Configures the endpoint
config :cooking_quest, CookingQuest.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hD113qXoIV9/+WxCRMoJW/wQjt411dzI4B99lOq82841Gg10LEfW3Q3soREsmVsq",
  render_errors: [view: CookingQuest.ErrorView, accepts: ~w(json)],
  pubsub: [name: CookingQuest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
