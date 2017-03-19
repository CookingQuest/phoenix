defmodule CookingQuest.GraphqlChannel do
  use Phoenix.Channel
  alias CookingQuest.{Schema}

  def join("graphql", _message, socket) do
    {:ok, socket}
  end

  def handle_in("run", operation, socket) do
    result = run(operation)
    {:reply, result, socket}
  end

  def run(%{"query" => query, "variables" => variables}) do
    Absinthe.run(query, Schema, variables: variables)
  end
end
