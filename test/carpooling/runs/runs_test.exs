defmodule CarPooling.RunsTest do
  use CarPooling.DataCase

  alias CarPooling.Runs
  alias CarPooling.Runs.Projections.Car
  alias CarPooling.Runs.Projections.Journey

  describe "create car" do
    @tag :integration
    test "should succeed with valid data" do
      factory_car = build(:car)
      assert {:ok, %Car{} = car} = Runs.create_car(factory_car)

      assert car.id == factory_car.id
      assert car.seats == factory_car.seats
    end

    @tag :integration
    test "should fail with invalid data and return error" do
      assert {:error, :validation_failure, errors} = Runs.create_car(build(:car, id: nil))
      assert errors == %{id: ["must be present"]}

      assert {:error, :validation_failure, errors} = Runs.create_car(build(:car, seats: 0))
      assert errors == %{seats: ["must be a number greater than or equal to 4"]}

      assert {:error, :validation_failure, errors} = Runs.create_car(build(:car, seats: 10))
      assert errors == %{seats: ["must be a number less than or equal to 6"]}

      assert {:error, :validation_failure, errors} = Runs.create_car(build(:car, seats: nil))

      assert errors == %{
               seats: ["must be present", "must be a number greater than or equal to 4"]
             }
    end

    @tag :integration
    test "should fail when id already taken and return error" do
      assert {:ok, %Car{}} = Runs.create_car(build(:car, id: 1))
      assert {:error, :validation_failure, errors} = Runs.create_car(build(:car, id: 1))
      assert errors == %{id: ["has already been taken"]}
    end
  end

  describe "journey test" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %Car{}} = Runs.create_car(build(:car))
      assert {:ok, %Journey{} = journey} = Runs.create_journey(build(:journey))
    end

    @tag :integration
    test "dropoff should succeed with valid data" do
      assert {:ok, %Car{}} = Runs.create_car(build(:car))

      journey = build(:journey)
      assert {:ok, %Journey{} = journey} = Runs.create_journey(journey)
      assert :ok = Runs.delete_journey(journey)
    end
  end
end
