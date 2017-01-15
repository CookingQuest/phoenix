defmodule CookingQuest.Graphql do
  alias CookingQuest.{Schema}

  def run(%{"query" => query, "variables" => variables}) do
    Absinthe.run(query, Schema, variables: variables) 
  end
end
