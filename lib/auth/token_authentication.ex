defmodule CookingQuest.TokenAuthentication do
  import Ecto.Query, only: [where: 3]

  alias CookingQuest.{AuthToken, Endpoint, Mailer, Repo, Mails}
  alias Phoenix.Token

  @token_max_age 1_800

  def provide_token(user) do
    send_token(user)
  end

  def verify_token_value(value) do
    AuthToken
    |> where([t], t.value == ^value)
    |> where([t], t.inserted_at > datetime_add(^Ecto.DateTime.utc, ^(@token_max_age * -1), "second"))
    |> Repo.one()
    |> verify_token()
  end

  defp verify_token(token) do
    token =
      token
      |> Repo.preload(:user)

    user_id = token.user.id

    case Token.verify(Endpoint, "user", token.value, max_age: @token_max_age) do
      {:ok, ^user_id} -> {:ok, token}

      # reason can be :invalid or :expired
      {:error, reason} ->
          {:error, reason}
    end
  end

  defp send_token(user) do
    user
    |> create_token()
    |> Mails.login(user)
    |> Mailer.deliver_later()

    {:ok, user}
  end

  # Creates a new token for the given user and returns the token value.
  defp create_token(user) do
    {:ok, auth_token} = AuthToken.create(user)
    auth_token.value
  end
end
