defmodule CarPooling.Runs.Events.CarCreated do
  @derive Jason.Encoder

  defstruct [
    :car_uuid,
    :id,
    :seats
  ]
end
