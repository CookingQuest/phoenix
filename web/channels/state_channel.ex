defmodule CookingQuest.StateChannel do
  use Phoenix.Channel
  alias CookingQuest.{Graphql}

  def join("state", _message, socket) do
    {:ok, socket}
  end

  @query """
  query GetUser($id: ID!) {
  user(id: $id) {name, stats {level, exp}}
  }
  """

  def handle_in("get", params, socket) do
    result = get_state(params)
    {:reply, result, socket}
  end

  def get_state(%{"route" => _route, "user_hash" => id}) do
    Graphql.run(%{"query" => @query, "variables" => %{"id" => id}})
  end

  def get_state(%{"route" => _route}) do
    {:ok, %{data: %{"route" => "tutorial"}}}
  end
end
