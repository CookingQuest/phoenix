defmodule CookingQuest.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string 
  end
end
