defmodule CarPooling.Runs.Queries.GetCarByJourney do
  import Ecto.Query

  alias CarPooling.Runs.Projections.Car
  alias CarPooling.Runs.Projections.Journey

  def new(id) do
    from(
      c in Car,
      inner_join: j in Journey,
      on: c.id == j.car_id,
      where: j.id == ^id,
      select: c
    )
  end
end
