defmodule GraphqlTest do
  use CookingQuest.ChannelCase
  alias CookingQuest.{AppChannel, User}

  @query """
  query GetUser($id: ID!) {
  user(id: $id) {name}
  }
  """

  test "get_user" do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(AppChannel, "app:graphql")

    %{id: id} = Repo.insert!(%User{name: "TestUser"})

    {:ok, socket: socket, id: id}
    msg = %{query: @query, variables: %{id: id}}
    ref = push(socket, "query", msg)
    assert_reply ref, :ok, %{data: %{"user" => %{"name" => "TestUser"}}}, 500
  end

  test "get_user_gq" do
    %{id: id} = Repo.insert!(%User{name: "TestUser"})
    variables = %{"id" => id}
    result = Absinthe.run(@query, CookingQuest.Schema, variables: variables)
    assert result == {:ok, %{data: %{"user" => %{"name" => "TestUser"}}}}
  end
end
