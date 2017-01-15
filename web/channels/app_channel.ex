defmodule CookingQuest.AppChannel do
  use Phoenix.Channel
  alias CookingQuest.{Graphql}
  
  def join("app:graphql", _message, socket) do
    {:ok, socket}
  end

  def handle_in("query", msg, socket) do 
    result = Graphql.run(msg)
    {:reply, result, socket}
  end

  @query """
  {user(id: 1) {name, stats {id, level}}}
  """
  
  def handle_in("initial_state", route, socket) do 
    result = Graphql.run(%{"query" => @query, "variables" => []})
    {:reply, result, socket}
  end
end
