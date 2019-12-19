defmodule CarPooling.Runs.Queries.GetAllCars do
  import Ecto.Query

  alias CarPooling.Runs.Projections.Car

  def new() do
    from(c in Car)
  end
end
