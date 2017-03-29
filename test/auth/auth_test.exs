defmodule AuthTest do
  use CookingQuest.ConnCase
  use Bamboo.Test
  alias CookingQuest.{Registration, Mails, UserCase}

  test "register" do
    {:ok, user} = UserCase.get_email() |> Registration.register
    token = Repo.preload(user, [:token]).token.value
    assert_delivered_email Mails.login(token, user)
    {:ok, updated_token} = Registration.login(token)
    assert user == updated_token.user
    assert token != updated_token
  end
end
