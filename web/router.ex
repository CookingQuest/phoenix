defmodule CookingQuest.Router do
  use CookingQuest.Web, :router

  forward "/graphql", Absinthe.Plug, schema: CookingQuest.Schema

  if Mix.env == :dev do
    # If using Phoenix
    forward "/emails", Bamboo.EmailPreviewPlug
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: CookingQuest.Schema
  end
end
