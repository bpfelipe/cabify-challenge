defmodule CarPooling.Runs.Commands.CreateJourney do
  defstruct journey_uuid: "",
            id: nil,
            people: nil,
            car_id: nil

  use ExConstructor
  use Vex.Struct

  validates(:journey_uuid, uuid: true)
  validates(:id, presence: true, unique_id: [true, command: "CreateJourney"])

  validates(:people,
    presence: true,
    number: [greater_than_or_equal_to: 1, less_than_or_equal_to: 6]
  )

  validates(:car_id, format: [with: ~r/^[0-9]+$/, allow_nil: true, message: "is invalid"])
end

defimpl CarPooling.Support.Middleware.Uniqueness.UniqueFields,
  for: CarPooling.Runs.Commands.CreateJourney do
  def unique(_command),
    do: [
      {:id, "has already been taken"}
    ]
end
