defmodule CookingQuest.GraphqlChannel do
  use Phoenix.Channel
  alias CookingQuest.{Graphql}

  def join("graphql", _message, socket) do
    {:ok, socket}
  end

  def handle_in("query", msg, socket) do
    result = Graphql.run(msg)
    {:reply, result, socket}
  end

  @query """
  {user(id: 1) {name, stats {level, exp}}}
  """

  def handle_in("initial_state", %{"route" => _route, "user" => _user}, socket) do
    result = Graphql.run(%{"query" => @query, "variables" => []})
    {:reply, result, socket}
  end

  def handle_in("initial_state", %{}, socket) do
    result = Graphql.run(%{"query" => @query, "variables" => []})
    IO.puts('hi')
    IO.inspect(result)
    {:reply, result, socket}
  end
end
