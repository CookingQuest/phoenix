defmodule GraphqlTest do 
  use CookingQuest.ChannelCase
  alias CookingQuest.AppChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(AppChannel, "app:graphql")

    {:ok, socket: socket}
  end
  
  test "get_user", %{socket: socket} do
    ref = push socket, "query", %{"body" => """
    {
    user(id: "1") {
    name
    }
    }
    """}
    assert_reply ref, :ok, %{data: %{"user" => %{"name" => "TestUser"}}}, 200
  end

  test "get_user_gq" do
    query = """
    {
    user(id: "1") {
    name
    }
    }
    """
    assert Absinthe.run(query, CookingQuest.Schema) == {:ok, %{data: %{"user" => %{"name" => "TestUser"}}}}
  end
end
