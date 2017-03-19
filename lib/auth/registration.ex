defmodule CookingQuest.Registration do
  alias CookingQuest.{TokenAuthentication, User, Repo, AuthToken}

  def login(token) do
    with {:ok, token} <- TokenAuthentication.verify_token_value(token),
      do: AuthToken.update(token)
  end

  def register(email) do
    changeset = User.changeset(%User{}, %{email: email})
    case Repo.insert(changeset) do
      {:ok, user} ->
        TokenAuthentication.provide_token(user)
      {:error, _changeset} -> :ok
    end
  end
end
