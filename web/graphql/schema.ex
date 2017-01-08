defmodule CookingQuest.Schema do
  use Absinthe.Schema
  import_types CookingQuest.Schema.Types

  query do
    field :user, :user do
      arg :id, :id
      
      resolve &CookingQuest.UserResolver.get/2
    end
  end

end

defmodule CookingQuest.UserResolver do
  alias CookingQuest.User
  
  def get(%{id: id}, _info) do
    {:ok, %User{id: id, name: "TestUser"}}
  end
end
