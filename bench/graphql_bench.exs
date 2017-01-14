defmodule GraphqlBench do
  use Benchfella
  
  @query ~s'{user(id: "1") {name}}'
  
  bench "get user" do 
    Absinthe.run(@query, CookingQuest.Schema) 
  end

end
