defmodule CookingQuest.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias CookingQuest.{Stats, User, Repo, AuthToken}


  schema "users" do
    field :name, :string
    field :email, :string
    has_one :stats, Stats
    has_one :token, AuthToken
  end

  @fields ~w(name email)

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @fields)
    |> validate_required([:email])
    |> unique_constraint(:email)
  end

  def create(params) do
    changeset(%User{}, params)
    |> put_assoc(:stats, params[:stats])
    |> Repo.insert
  end
end

defmodule CookingQuest.Stats do
  use Ecto.Schema
  import Ecto.Changeset
  alias CookingQuest.{User}

  schema "stats" do
    field :level, :integer
    belongs_to :user, User
  end

  @fields ~w(level)

  def changeset(stats, params \\ %{}) do
    stats
    |> cast(params, @fields)
  end
end
