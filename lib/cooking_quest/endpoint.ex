defmodule CookingQuest.Endpoint do
  use Phoenix.Endpoint, otp_app: :cooking_quest

  socket "/socket", CookingQuest.Socket  

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug CookingQuest.Router
end
