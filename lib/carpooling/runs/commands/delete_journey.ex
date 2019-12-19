defmodule CarPooling.Runs.Commands.DeleteJourney do
  defstruct journey_uuid: ""

  use ExConstructor
  use Vex.Struct

  alias CarPooling.Runs.Projections.Journey
  alias CarPooling.Runs.Commands.DeleteJourney

  validates(:journey_uuid, uuid: true)

  def assign(%DeleteJourney{} = delete, %Journey{uuid: journey_uuid}) do
    %DeleteJourney{delete | journey_uuid: journey_uuid}
  end
end
