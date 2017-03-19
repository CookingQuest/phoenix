defmodule CookingQuest.Router do
  use CookingQuest.Web, :router
  alias CookingQuest.{Schema}

  forward "/graphql", Absinthe.Plug, schema: Schema

  if Mix.env == :dev do
    # If using Phoenix
    forward "/emails", Bamboo.EmailPreviewPlug
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Schema
  end
end
