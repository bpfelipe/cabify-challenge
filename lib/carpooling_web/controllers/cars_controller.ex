defmodule CarPoolingWeb.CarController do
  use CarPoolingWeb, :controller

  alias CarPooling.Runs
  # alias CarPooling.Runs.Projections.Car

  action_fallback(CarPoolingWeb.FallbackController)

  def create(conn, car_list) do
    %{"_json" => cars} = car_list

    with {:ok, cars_created} <- Runs.create_cars(cars) do
      conn
      |> put_status(:ok)
      |> render("cars.json", cars: cars_created)
    end
  end
end
