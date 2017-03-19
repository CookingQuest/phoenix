defmodule CookingQuest.Schema.Types do
  use Absinthe.Schema.Notation
  alias CookingQuest.{Schema, Stats, Repo}
  use Absinthe.Ecto, repo: Repo

  object :user do
    field :id, :id
    field :name, :string
    field :stats, :stats do
      resolve fn user, _, _ ->
        batch({Schema.Helpers, :by_id, Stats}, user.id, fn batch_results ->
          {:ok, Map.get(batch_results, user.id)}
        end) 
      end
    end
  end

  object :stats do
    field :id, :id
    field :level, :integer
    field :exp, :integer
    field :user_id, :id
    field :user, :user, resolve: assoc(:user)
  end
end
