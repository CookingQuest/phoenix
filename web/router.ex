defmodule CookingQuest.Router do
  use CookingQuest.Web, :router

  forward "/graphql", Absinthe.Plug, schema: CookingQuest.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: CookingQuest.Schema
end
