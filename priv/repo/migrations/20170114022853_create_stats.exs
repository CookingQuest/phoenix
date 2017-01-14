defmodule CookingQuest.Repo.Migrations.CreateStats do
  use Ecto.Migration

  def change do
    create table(:stats) do
      add :level, :integer
      add :user_id, references(:users)
    end
  end
end
