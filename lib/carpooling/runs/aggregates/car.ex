defmodule CarPooling.Runs.Aggregates.Car do
  defstruct [
    :uuid,
    :id,
    :seats
  ]

  alias CarPooling.Runs.Aggregates.Car
  alias CarPooling.Runs.Events.CarCreated
  alias CarPooling.Runs.Commands.CreateCar

  @doc """
  Creates a new Car List
  """

  def execute(%Car{uuid: nil}, %CreateCar{} = create_car) do
    %CarCreated{
      car_uuid: create_car.car_uuid,
      id: create_car.id,
      seats: create_car.seats
    }
  end

  def apply(%Car{uuid: nil}, %CarCreated{} = car_created) do
    %Car{
      uuid: car_created.car_uuid,
      id: car_created.id,
      seats: car_created.seats
    }
  end
end
