defmodule CarPoolingWeb.DropOffController do
  use CarPoolingWeb, :controller

  alias CarPooling.Runs

  action_fallback(CarPoolingWeb.FallbackController)

  def dropoff(conn, %{"ID" => id}) do
    case Runs.dropoff_journey(id) do
      :ok ->
        conn
        |> put_status(200)
        |> render("ok.json")

      {:error, :not_found} ->
        conn
        |> put_status(404)
        |> render("not_found.json")

      {:error, :bad_request} ->
        conn
        |> put_status(400)
        |> render("bad_request.json")

      _ ->
        conn
        |> put_status(400)
        |> render("bad_request.json")
    end
  end
end
