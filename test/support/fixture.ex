defmodule CarPooling.Fixture do
  import CarPooling.Factory

  alias CarPooling.Runs

  def create_cars(_context) do
    {:ok, car_list} = fixture(:car_list)

    [car_list]
  end

  def fixture(resource, attrs \\ [])

  def fixture(:car_list, attrs) do
    build(:car_list, attrs) |> Runs.create_cars()
  end
end
