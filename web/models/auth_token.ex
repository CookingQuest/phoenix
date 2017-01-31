defmodule CookingQuest.AuthToken do
  use CookingQuest.Web, :model
  alias Phoenix.Token
  alias CookingQuest.{Endpoint, User, AuthToken, Repo}

  schema "auth_tokens" do
    field :value, :string
    belongs_to :user, User

    timestamps(updated_at: false)
  end

  def create(user) do
    %AuthToken{user: user}
    |> changeset()
    |> Repo.insert
  end

  def update(token) do
    token
    |> changeset()
    |> Repo.update
  end

  defp changeset(token) do
    token
    |> change
    |> cast_assoc(:user)
    |> put_change(:value, generate_token(token.user))
    |> validate_required([:value, :user])
    |> unique_constraint(:value)
  end

  defp generate_token(user) do
    Token.sign(Endpoint, "user", user.id)
  end
end
