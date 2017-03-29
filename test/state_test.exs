defmodule StateTest do
  use CookingQuest.ModelCase
  alias CookingQuest.{StateChannel, UserCase}

  setup do
    %{id: id} = UserCase.get_user() |> Repo.insert!
    {:ok, [id: id]}
  end

  test "initialState with user", context do
    id = context[:id]
    result = StateChannel.get_state(%{"route" => "", "user_hash" => id})
    assert result == {
      :ok, %{data: %{"user" => %{"name" => "jm", "stats" => %{"exp" => 0, "level" => 1.0}}}}}
  end

  test "initialState without user" do
    result = StateChannel.get_state(%{"route" => ""})
    assert result == {:ok, %{data: %{"route" => "tutorial"}}}
  end
end
