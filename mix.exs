defmodule CookingQuest.Mixfile do
  use Mix.Project

  def project do
    [app: :cooking_quest,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps(),
     dialyzer: [plt_add_deps: :transitive]]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {CookingQuest, []},
     applications: [:phoenix, :phoenix_html, :phoenix_pubsub, :cowboy, :logger,
                    :phoenix_ecto, :postgrex, :absinthe, :absinthe_ecto,
                    :absinthe_plug, :bamboo]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:absinthe, "~> 1.2.6"},
     {:absinthe_plug, "~> 1.2.5"},
     {:absinthe_ecto, git: "https://github.com/absinthe-graphql/absinthe_ecto.git"},
     {:bamboo, "~> 0.8"},
     {:cowboy, "~> 1.1.2"},
     {:distillery, "~> 1.3.4"},
     {:phoenix, "~> 1.2.3"},
     {:phoenix_ecto, "~> 3.2.3"},
     {:phoenix_html, "~> 2.9.3"},
     {:phoenix_pubsub, "~> 1.0.1"},
     {:postgrex, "~> 0.13.2"},
     {:benchfella, "~> 0.3.4", only: [:dev]},
     {:dialyxir, "~> 0.5.0", only: [:dev]}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
