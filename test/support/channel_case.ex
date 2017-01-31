defmodule CookingQuest.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ChannelTest

      alias CookingQuest.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query


      # The default endpoint for testing
      @endpoint CookingQuest.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(CookingQuest.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(CookingQuest.Repo, {:shared, self()})
    end

    :ok
  end
end
