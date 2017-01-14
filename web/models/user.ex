defmodule CookingQuest.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias CookingQuest.{Stats, User, Repo}
  
  
  schema "users" do
    field :name, :string
    has_one :stats, Stats
  end

  @fields ~w(name)
  
  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @fields) 
  end

  def create(params) do
    cs = changeset(%User{}, params) 
    |> put_assoc(:stats, params[:stats])
    if cs.valid? do
      Repo.insert(cs)
    else
      cs
    end
  end
end

defmodule CookingQuest.Stats do
  use Ecto.Schema
  import Ecto.Changeset
  alias CookingQuest.{Repo, User}

  schema "stats" do
    field :level, :integer
    belongs_to :user, User
  end

  @fields ~w(level)
  
  def changeset(stats, params \\ %{}) do
    stats
    |> cast(params, [:level])
  end
end
