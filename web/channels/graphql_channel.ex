defmodule CookingQuest.GraphqlChannel do
  use Phoenix.Channel
  alias CookingQuest.{Schema, Graphql}

  def join("graphql", _message, socket) do
    {:ok, socket}
  end

  def handle_in("run", operation, socket) do
    result = Graphql.run(operation)
    {:reply, result, socket}
  end
end
