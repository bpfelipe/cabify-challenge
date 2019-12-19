defmodule CarPooling.Runs.Queries.GetCarById do
  import Ecto.Query

  alias CarPooling.Runs.Projections.Car

  def new(id) do
    from(c in Car,
      where: c.id == ^id
    )
  end
end
