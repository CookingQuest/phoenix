defmodule CookingQuest.StateChannel do
  use Phoenix.Channel
  alias CookingQuest.{GraphqlChannel}

  def join("state", _message, socket) do
    {:ok, socket}
  end

  @query """
  query GetUser($id: ID!) {
  user(id: $id) {name, stats {level, exp}}
  }
  """

  def handle_in("get", %{"route" => _route, "user_hash" => id}, socket) do
    result = GraphqlChannel.run(%{"query" => @query, "variables" => %{"id" => id}})
    {:reply, result, socket}
  end

  def handle_in("get", %{"route" => _route}, socket) do
    result = {:ok, %{data: %{"route" => "tutorial"}}}
    {:reply, result, socket}
  end
end
