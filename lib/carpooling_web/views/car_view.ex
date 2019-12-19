defmodule CarPoolingWeb.CarView do
  use CarPoolingWeb, :view
  alias CarPoolingWeb.CarView

  def render("cars.json", %{cars: cars}) do
    %{data: render_many(cars, CarView, "car.json")}
  end

  def render("car.json", %{car: car}) do
    %{
      id: car.id,
      inserted_at: car.inserted_at,
      seats: car.seats,
      updated_at: car.updated_at,
      car: car.uuid
    }
  end
end
