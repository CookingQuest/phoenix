defmodule :release_tasks do
  alias CookingQuest.{Repo}

  def migrate do
    {:ok, _} = Application.ensure_all_started(:cooking_quest)
    path = Application.app_dir(:cooking_quest, "priv/repo/migrations")
    Ecto.Migrator.run(Repo, path, :up, all: true)
  end
end
