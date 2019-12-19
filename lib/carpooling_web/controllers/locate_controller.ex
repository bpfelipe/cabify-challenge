defmodule CarPoolingWeb.LocateController do
  use CarPoolingWeb, :controller

  alias CarPooling.Runs
  alias CarPooling.Runs.Projections.Car

  action_fallback(CarPoolingWeb.FallbackController)

  def locate(conn, %{"ID" => id}) do
    with {:ok, %Car{}} = car <- Runs.locate_journey(id) do
      conn
      |> put_status(200)
      |> render("car.json", car: car)
    else
      {:ok, :waiting_car} ->
        conn
        |> put_status(204)
        |> render("no_content.json")

      {:error, :group_not_found} ->
        conn
        |> put_status(404)
        |> render("not_found.json")

      _ ->
        conn
        |> put_status(400)
        |> render("bad_request.json")
    end
  end
end
