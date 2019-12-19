defmodule CarPooling.Runs.Projectors.Car do
  use Commanded.Projections.Ecto, name: "Runs.Projectors.Car", consistency: :strong

  alias CarPooling.Runs.Events.CarCreated
  alias CarPooling.Runs.Projections.Car

  project %CarCreated{} = car_created do
    Ecto.Multi.insert(multi, :car, %Car{
      uuid: car_created.car_uuid,
      id: car_created.id,
      seats: car_created.seats
    })
  end
end
