defmodule CarPooling.Runs.Validators.UniqueId do
  use Vex.Validator

  alias CarPooling.Runs

  def validate(value, options) do
    Vex.Validators.By.validate(value,
      function: fn value -> !command?(value, options) end,
      message: "has already been taken"
    )
  end

  defp command?(id, options) do
    with [true, {:command, command}] <- options, !is_nil(id) do
      case command do
        "CreateCar" ->
          case Runs.car_by_id(id) do
            nil -> false
            _ -> true
          end

        "CreateJourney" ->
          case Runs.journey_by_id(id) do
            nil -> false
            _ -> true
          end
      end
    else
      _ ->
        nil
    end
  end
end
