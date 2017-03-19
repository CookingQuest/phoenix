defmodule CookingQuest.Schema.Helpers do
  import Ecto.Query
  alias CookingQuest.{Repo}

  def by_id(model, ids) do
    model
    |> where([m], m.user_id in ^ids)
    |> Repo.all
    |> Map.new(&{&1.user_id, &1})
  end
end
