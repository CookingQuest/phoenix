defmodule StateTest do
  use CookingQuest.ModelCase
  alias CookingQuest.{StateChannel, User, Stats}

  setup do
    %{id: id} = Repo.insert!(%User{name: "jm", email: "jm", stats: %Stats{level: 1, exp: 0}})
    {:ok, [id: id]}
  end

  test "initialState with user", context do
    id = context[:id]
    result = StateChannel.get_state(%{"route" => "", "user_hash" => id})
    assert result == {:ok, %{data: %{"user" => %{"name" => "jm",
                                                 "stats" => %{"level" => 1, "exp" => 0}}}}}
  end

  test "initialState without user" do
    result = StateChannel.get_state(%{"route" => ""})
    assert result == {:ok, %{data: %{"route" => "tutorial"}}}
  end
end
