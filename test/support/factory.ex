defmodule CarPooling.Factory do
  use ExMachina

  # alias CarPooling.Cars.Car
  alias CarPooling.Runs.Commands.CreateCar
  alias CarPooling.Runs.Commands.CreateJourney
  alias CarPooling.Runs.Projections.Journey
  alias CarPooling.Runs.Projections.Car

  def car_factory do
    %{
      id: Enum.random(0..10000),
      seats: 6
    }
  end

  def journey_factory do
    %{
      id: Enum.random(0..10000),
      people: Enum.random(1..6)
    }
  end

  @spec create_car_factory :: %{:__struct__ => atom, optional(atom) => any}
  def create_car_factory do
    struct(CreateCar, build(:car, id: 1, seats: 6))
  end

  @spec create_journey_factory :: %{:__struct__ => atom, optional(atom) => any}
  def create_journey_factory do
    struct(CreateJourney, build(:journey, car_id: 1, id: 1, people: 4))
  end

  def delete_journey_factory do
    struct(DeleteJourney, build(:journey, car_id: 1, id: 1, people: 4))
  end
end
