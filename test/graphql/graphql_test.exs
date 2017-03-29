defmodule GraphqlTest do
  use CookingQuest.ModelCase
  alias CookingQuest.{UserCase, Graphql}


  setup do
    %{id: id} = UserCase.get_user() |> Repo.insert!
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
    assert Graphql.run(msg) == {
      :ok,  %{data: %{"user" => %{"name" => "jm", "stats" => %{"level" => 1.0, "exp" => 0}}}}
    }
  end
end
