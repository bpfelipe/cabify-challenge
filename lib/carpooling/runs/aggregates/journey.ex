defmodule CarPooling.Runs.Aggregates.Journey do
  defstruct [
    :uuid,
    :id,
    :people,
    :car_id,
    deleted?: false
  ]

  alias CarPooling.Runs.Aggregates.Journey
  alias CarPooling.Runs.Events.JourneyCreated
  alias CarPooling.Runs.Events.JourneyDeleted
  alias CarPooling.Runs.Commands.CreateJourney
  alias CarPooling.Runs.Commands.DeleteJourney

  @doc """
  Creates a new Journey
  """

  def execute(%Journey{uuid: nil}, %CreateJourney{} = create_journey) do
    %JourneyCreated{
      journey_uuid: create_journey.journey_uuid,
      id: create_journey.id,
      people: create_journey.people,
      car_id: create_journey.car_id
    }
  end

  def execute(
        %Journey{
          uuid: journey_uuid,
          deleted?: false
        },
        %DeleteJourney{journey_uuid: journey_uuid}
      ) do
    %JourneyDeleted{
      journey_uuid: journey_uuid
    }
  end

  def apply(%Journey{uuid: nil}, %JourneyCreated{} = journey_created) do
    %Journey{
      uuid: journey_created.journey_uuid,
      id: journey_created.id,
      people: journey_created.people,
      car_id: journey_created.car_id
    }
  end

  def apply(%Journey{} = journey, %JourneyDeleted{}) do
    %Journey{journey | deleted?: true}
  end

  @doc """
  Stop the journey aggregate after it has been deleted
  """
  def after_event(%JourneyDeleted{}), do: :stop
  def after_event(_), do: :timer.hours(1)
  def after_command(_), do: :timer.hours(1)
  def after_error(_), do: :timer.hours(1)
end
