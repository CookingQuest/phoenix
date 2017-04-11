defmodule CookingQuest.Schema.Types do
  use Absinthe.Schema.Notation
  alias CookingQuest.{Schema, User.Stats, Repo}
  use Absinthe.Ecto, repo: Repo

  object :user do
    field :id, :id
    field :name, :string
    field :stats, :stats do
      resolve fn user, _, _ -> resolve_stats(user.id) end
    end
  end

  object :stats do
    field :id, :id
    field :level, :float do
      resolve {Stats, :calc_level}
    end
    field :exp, :integer
    field :user_id, :id
    field :user, :user, resolve: assoc(:user)
  end

  defp resolve_stats(user_id) do
    batch({Schema.Helpers, :by_id, Stats}, user_id, fn batch_results ->
      {:ok, Map.get(batch_results, user_id)}
    end)
  end
end
