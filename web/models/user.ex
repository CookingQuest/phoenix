defmodule CookingQuest.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias CookingQuest.{User.Stats, User, Repo, AuthToken}


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

defmodule CookingQuest.User.Stats do
  use Ecto.Schema
  import Ecto.Changeset
  alias CookingQuest.{User}

  schema "stats" do
    field :exp, :integer
    belongs_to :user, User
  end

  @fields ~w(level)

  def changeset(stats, params \\ %{}) do
    stats
    |> cast(params, @fields)
  end

  def calc_level(%{exp: exp}, _, _) do
    {:ok, 0.01 * exp + 1}
  end
end
