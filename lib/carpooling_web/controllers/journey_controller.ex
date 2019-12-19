defmodule CarPoolingWeb.JourneyController do
  use CarPoolingWeb, :controller

  alias CarPooling.Runs
  alias CarPooling.Runs.Projections.Journey

  action_fallback(CarPoolingWeb.FallbackController)

  def create(conn, params) do
    journey_params =
      with %{"journey" => journey_params} <- params do
        journey_params
      else
        %{"id" => id, "people" => people} ->
          %{"id" => id, "people" => people}
      end

    with {:ok, %Journey{} = journey} <- Runs.create_journey(journey_params) do
      conn
      |> put_status(:ok)
      |> render("show.json", journey: journey)
    end
  end
end
