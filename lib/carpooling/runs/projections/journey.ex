defmodule CarPooling.Runs.Projections.Journey do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "journeys" do
    field(:id, :integer, unique: true)
    field(:people, :integer)
    field(:car_id, :integer)

    timestamps()
  end
end
