defmodule GraphqlBench do
  use Benchfella 
  
  bench "get user" do
    query = """
    {
    user(id: "1") {
    name
    }
    }
    """
    Absinthe.run(query, CookingQuest.Schema) 
  end
  
end
