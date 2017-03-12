defmodule CookingQuest.ApiChannel do
  use Phoenix.Channel
  alias CookingQuest.{Registration}

  def join("api", _message, socket) do
    {:ok, socket}
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
