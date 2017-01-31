defmodule CookingQuest.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
    end
    create table(:stats) do
      add :level, :integer
      add :user_id, references(:users)
    end
    create table(:auth_tokens) do
      add :value, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(updated_at: false)
    end

    create unique_index(:users, [:email])

    create index(:auth_tokens, [:user_id])
    create unique_index(:auth_tokens, [:value])
  end
end
