defmodule CookingQuest.Schema.Helpers do
  import Ecto.Query
  alias CookingQuest.{Repo} 
  
  def by_id(model, ids) do
    IO.puts "as"
    model
    |> where([m], m.user_id in ^ids)
    |> Repo.all
    |> Map.new(&{&1.id, &1})
  end
end
