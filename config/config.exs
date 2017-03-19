use Mix.Config

config :cooking_quest,
  ecto_repos: [CookingQuest.Repo]


config :cooking_quest, CookingQuest.Endpoint,
  url: [host: "localhost", port: 8080],
  secret_key_base: "hD113qXoIV9/+WxCRMoJW/wQjt411dzI4B99lOq82841Gg10LEfW3Q3soREsmVsq",
  render_errors: [view: CookingQuest.ErrorView, accepts: ~w(json)],
  pubsub: [name: CookingQuest.PubSub,
           adapter: Phoenix.PubSub.PG2]


config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
