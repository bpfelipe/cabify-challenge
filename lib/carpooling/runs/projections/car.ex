defmodule CarPooling.Runs.Projections.Car do
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "cars" do
    field(:id, :integer, unique: true)
    field(:seats, :integer)

    timestamps()
  end
end
