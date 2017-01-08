defmodule CookingQuest.Router do
  use CookingQuest.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CookingQuest do
    pipe_through :api
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: CookingQuest.Schema
end
