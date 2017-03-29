defmodule CookingQuest.UserCase do
  alias CookingQuest.{User}


  def get_user do
    %User{name: "jm", email: get_email(), stats: %User.Stats{exp: 0}}
  end

  defp counter do
    System.unique_integer [:positive]
  end

  def get_email do
    "jm-#{counter()}@g.com"
  end
end
