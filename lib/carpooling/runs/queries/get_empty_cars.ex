defmodule CarPooling.Runs.Queries.GetEmptyCars do
  import Ecto.Query

  alias CarPooling.Runs.Projections.Car
  alias CarPooling.Runs.Projections.Journey

  def new(desired_seats) when is_integer(desired_seats) do
    from(
      c in Car,
      left_join: j in Journey,
      on: c.id == j.car_id,
      where: is_nil(j.id) and c.seats >= ^desired_seats and not is_nil(c.id),
      order_by: [asc: c.seats]
    )
  end
end
