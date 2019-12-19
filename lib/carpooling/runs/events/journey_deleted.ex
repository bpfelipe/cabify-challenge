defmodule CarPooling.Runs.Events.JourneyDeleted do
  @derive Jason.Encoder

  defstruct [
    :journey_uuid
  ]
end
