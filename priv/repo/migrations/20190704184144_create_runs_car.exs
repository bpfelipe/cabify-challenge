defmodule CarPooling.Repo.Migrations.CreateCarPooling.Runs.Car do
  use Ecto.Migration

  def change do
    create table(:cars, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :id, :integer
      add :seats, :integer

      timestamps()
    end

    create unique_index(:cars, [:id])
  end
end
