defmodule CarPooling.Runs.Commands.CreateCar do
  defstruct car_uuid: "",
            id: nil,
            seats: nil

  use ExConstructor
  use Vex.Struct

  validates(:car_uuid, uuid: true)

  validates(:id,
    presence: true,
    unique_id: [true, command: "CreateCar"]
  )

  validates(:seats,
    presence: true,
    number: [greater_than_or_equal_to: 4, less_than_or_equal_to: 6]
  )
end

defimpl CarPooling.Support.Middleware.Uniqueness.UniqueFields,
  for: CarPooling.Runs.Commands.CreateCar do
  def unique(_command),
    do: [
      {:id, "has already been taken"}
    ]
end
