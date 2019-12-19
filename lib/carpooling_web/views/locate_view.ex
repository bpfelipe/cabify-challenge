defmodule CarPoolingWeb.LocateView do
  use CarPoolingWeb, :view
  alias CarPoolingWeb.LocateView
  alias CarPooling.Runs.Projections.Car

  def render("car.json", %{car: car}) do
    with {:ok, %Car{} = car} <- car do
      %{
        id: car.id,
        seats: car.seats
      }
    else
      _ ->
        nil
    end
  end

  def render("no_content.json", _assigns) do
    %{ok: %{detail: "The group is waiting for an available car"}}
  end

  def render("not_found.json", _assigns) do
    %{errors: %{detail: "Group not found"}}
  end

  def render("bad_request.json", _assigns) do
    %{errors: %{detail: "Bad Request"}}
  end
end
