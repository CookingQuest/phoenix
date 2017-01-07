defmodule CookingQuest.AppChannel do
  use Phoenix.Channel

  def join("app:graphql", _message, socket) do
    {:ok, socket}
  end 
end
