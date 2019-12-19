defmodule CarPooling.Runs.Supervisor do
  use Supervisor

  alias CarPooling.Runs

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init(
      [
        Runs.Projectors.Car,
        Runs.Projectors.Journey
      ],
      strategy: :one_for_one
    )
  end
end
