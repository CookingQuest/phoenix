defmodule CookingQuest.AppChannel do
  use Phoenix.Channel

  def join("app:graphql", _message, socket) do
    {:ok, socket}
  end

  def handle_in("query", %{"query" => query, "variables" => variables}, socket) do 
    result = Absinthe.run(query, CookingQuest.Schema, variables: variables) 
    {:reply, result, socket}
  end
end
