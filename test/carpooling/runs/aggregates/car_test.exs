defmodule CarPooling.Runs.Aggregates.CarTest do
  use CarPooling.AggregateCase, aggregate: CarPooling.Runs.Aggregates.Car
  alias CarPooling.Runs.Events.CarCreated

  describe "create car" do
    @tag :unit
    test "should succeed when valid" do
      uuid = UUID.uuid4()

      assert_events(build(:create_car, car_uuid: uuid), [
        %CarCreated{
          car_uuid: uuid,
          id: 1,
          seats: 6
        }
      ])
    end
  end
end
