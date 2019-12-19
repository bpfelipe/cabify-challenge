defmodule CarPooling.Runs.Events.JourneyCreated do
  @derive Jason.Encoder

  defstruct [
    :journey_uuid,
    :id,
    :people,
    :car_id
  ]
end
