defmodule CookingQuest.AppChannel do
  use Phoenix.Channel
  alias CookingQuest.{Graphql, Registration}

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

  def handle_in("initial_state", %{"route" => _route, "user" => _user}, socket) do
    result = Graphql.run(%{"query" => @query, "variables" => []})
    {:reply, result, socket}
  end

  def handle_in("call", %{"method" => method, "params" => params}, socket) do
    result = call(method, params)
    {:reply, result, socket}
  end


  @methods %{"register" => &Registration.register/1}

  @spec call(String.t, list) :: {:ok, any}
  def call(method, params) do
    case Map.fetch(@methods, method) do
      :error -> {:error, "No such function"}
      {:ok, m} ->
        try do
          apply(m, params)
        rescue
          e -> {:error, Exception.message(e)}
        end
    end
  end
end
