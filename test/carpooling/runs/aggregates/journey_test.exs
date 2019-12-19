defmodule CarPooling.Runs.Aggregates.JourneyTest do
  use CarPooling.AggregateCase, aggregate: CarPooling.Runs.Aggregates.Journey
  alias CarPooling.Runs.Events.JourneyCreated

  describe "create journey" do
    @tag :unit
    test "should succeed when valid" do
      uuid = UUID.uuid4()

      assert_events(build(:create_journey, journey_uuid: uuid), [
        %JourneyCreated{
          journey_uuid: uuid,
          id: 1,
          people: 4,
          car_id: 1
        }
      ])
    end
  end
end
