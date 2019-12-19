defmodule CarPooling.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(CarPooling.Repo, []),
      supervisor(CarPoolingWeb.Endpoint, []),
      supervisor(CarPooling.Runs.Supervisor, []),
      worker(CarPooling.Support.Unique, [])
    ]

    opts = [strategy: :one_for_one, name: CarPooling.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    CarPoolingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
