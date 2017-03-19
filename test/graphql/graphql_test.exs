defmodule GraphqlTest do
  use CookingQuest.ChannelCase
  alias CookingQuest.{Graphql, User, Stats, ApiChannel}


  setup do
    %{id: id} = Repo.insert!(%User{name: "jm", email: "jm", stats: %Stats{level: 1, exp: 0}})
    {:ok, [id: id]}
  end

  @query """
  query GetUser($id: ID!) {
  user(id: $id) {name, stats {level, exp}}
  }
  """

  test "api methods" do
    methods = Map.keys(ApiChannel.methods())
    assert(
      "register" in methods and
      "query" in methods and
      "initial_state" in methods
    )
  end

  test "get_user", context do
    id = context[:id]

    msg = %{"query" => @query, "variables" => %{"id" => id}}
    assert Graphql.run(msg) == {:ok,  %{data: %{"user" => %{"name" => "jm",
                                                            "stats" => %{"level" => 1, "exp" => 0}}}}}
  end

  test "initialState with user", context do
    id = context[:id]
    result = Graphql.initial_state(%{"route" => "", "user" => id})
    assert result == {:ok, %{data: %{"user" => %{"name" => "jm",
                                                 "stats" => %{"level" => 1, "exp" => 0}}}}}
  end

  test "initialState without user" do
    result = Graphql.initial_state(%{"route" => ""})
    assert result == {:ok, %{data: %{"route" => "tutorial"}}}
  end
end
