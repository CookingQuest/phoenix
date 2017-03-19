defmodule GraphqlTest do
  use CookingQuest.ModelCase
  alias CookingQuest.{Graphql, User, Stats}


  setup do
    %{id: id} = Repo.insert!(%User{name: "jm", email: "jm", stats: %Stats{level: 1, exp: 0}})
    {:ok, [id: id]}
  end

  @query """
  query GetUser($id: ID!) {
  user(id: $id) {name, stats {level, exp}}
  }
  """

  test "get_user", context do
    id = context[:id]

    msg = %{"query" => @query, "variables" => %{"id" => id}}
    assert Graphql.run(msg) == {:ok,  %{data: %{"user" => %{"name" => "jm",
                                                            "stats" => %{"level" => 1, "exp" => 0}}}}}
  end
end
