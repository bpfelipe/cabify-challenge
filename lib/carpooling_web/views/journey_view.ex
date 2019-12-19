defmodule CarPoolingWeb.JourneyView do
  use CarPoolingWeb, :view
  alias CarPoolingWeb.JourneyView

  def render("show.json", %{journey: journey}) do
    %{journey: render_one(journey, JourneyView, "journey.json")}
  end

  def render("journey.json", %{journey: journey}) do
    %{
      id: journey.id,
      inserted_at: journey.inserted_at,
      people: journey.people,
      car_id: journey.car_id
    }
  end
end
