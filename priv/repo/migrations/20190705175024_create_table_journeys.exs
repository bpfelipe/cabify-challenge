defmodule CarPooling.Repo.Migrations.CreateTableJourneys do
  use Ecto.Migration

  def change do
    create table(:journeys, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :id, :integer
      add :people, :integer
      add :car_id, :integer

      timestamps()
    end

    create unique_index(:journeys, [:id])
  end
end
