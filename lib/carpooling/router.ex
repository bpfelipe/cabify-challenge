defmodule CarPooling.Router do
  use Commanded.Commands.Router

  alias CarPooling.Runs.Aggregates.Car
  alias CarPooling.Runs.Commands.CreateCar

  alias CarPooling.Runs.Aggregates.Journey
  alias CarPooling.Runs.Commands.CreateJourney
  alias CarPooling.Runs.Commands.DeleteJourney

  alias CarPooling.Support.Middleware.Uniqueness
  alias CarPooling.Support.Middleware.Validate

  middleware(Validate)
  middleware(Uniqueness)

  dispatch(CreateCar, to: Car, identity: :car_uuid)

  dispatch(CreateJourney, to: Journey, identity: :journey_uuid)

  dispatch(DeleteJourney, to: Journey, identity: :journey_uuid, lifespan: Journey)
end
