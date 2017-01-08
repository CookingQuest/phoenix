defmodule GraphqlTest do 
  use CookingQuest.ChannelCase
  alias CookingQuest.{AppChannel, Repo, User}

  @query """
  query GetUser($id: ID!) {
  user(id: $id) {name}
  }
  """
  
  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(AppChannel, "app:graphql")

    %{id: id} = Repo.insert!(%User{name: "TestUser"})

    {:ok, socket: socket, id: id}
  end

  test "get_user", %{socket: socket, id: id} do
    msg = %{query: @query, variables: %{id: id}}
    ref = push(socket, "query", msg)
    assert_reply ref, :ok, %{data: %{"user" => %{"name" => "TestUser"}}}, 250
  end

  test "get_user_gq", %{id: id} do
    variables = %{"id" => id} 
    result = Absinthe.run(@query, CookingQuest.Schema, variables: variables)
    assert result == {:ok, %{data: %{"user" => %{"name" => "TestUser"}}}}
  end
end
