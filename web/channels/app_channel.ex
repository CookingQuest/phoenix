defmodule CookingQuest.AppChannel do
  use Phoenix.Channel

  def join("app:graphql", _message, socket) do
    {:ok, socket}
  end

  def handle_in("query", %{"body" => body}, socket) do 
    result = Absinthe.run(body, CookingQuest.Schema) 
    {:reply, result, socket}
  end
end
