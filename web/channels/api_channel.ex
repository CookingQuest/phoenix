defmodule CookingQuest.ApiChannel do
  use Phoenix.Channel
  alias CookingQuest.{Registration}

  def join("api", _message, socket) do
    {:ok, socket}
  end

  def handle_in("register", email, socket), do: {:reply, Registration.register(email), socket}

end
