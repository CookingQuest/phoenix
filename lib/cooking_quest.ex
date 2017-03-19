defmodule CookingQuest do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(CookingQuest.Repo, []),
      # Start the endpoint when the application starts
      supervisor(CookingQuest.Endpoint, []),
      # Start your own worker by calling: CookingQuest.Worker.start_link(arg1, arg2, arg3)
      # worker(CookingQuest.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CookingQuest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CookingQuest.Endpoint.config_change(changed, removed)
    :ok
  end
end
