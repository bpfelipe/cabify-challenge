defmodule CarPooling.Runs.Queries.GetJourneyById do
  import Ecto.Query

  alias CarPooling.Runs.Projections.Journey

  def new(id) do
    from(c in Journey,
      where: c.id == ^id
    )
  end
end
