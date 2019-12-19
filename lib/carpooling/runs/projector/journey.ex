defmodule CarPooling.Runs.Projectors.Journey do
  use Commanded.Projections.Ecto, name: "Runs.Projectors.Journey", consistency: :strong

  alias CarPooling.Runs.Events.JourneyCreated
  alias CarPooling.Runs.Projections.Journey

  project %JourneyCreated{} = journey_created do
    Ecto.Multi.insert(multi, :journey, %Journey{
      uuid: journey_created.journey_uuid,
      id: journey_created.id,
      people: journey_created.people,
      car_id: journey_created.car_id
    })
  end
end
