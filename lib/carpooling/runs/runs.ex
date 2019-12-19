defmodule CarPooling.Runs do
  @moduledoc """
  The boundary for the Runs system.
  """

  alias CarPooling.Runs.Commands.CreateCar
  alias CarPooling.Runs.Commands.CreateJourney
  alias CarPooling.Runs.Commands.DeleteJourney
  alias CarPooling.Runs.Projections.Car
  alias CarPooling.Runs.Projections.Journey
  alias CarPooling.Router
  alias CarPooling.Repo
  alias CarPooling.Runs.Queries.GetCarById
  alias CarPooling.Runs.Queries.GetAllCars
  alias CarPooling.Runs.Queries.GetEmptyCars
  alias CarPooling.Runs.Queries.GetJourneyById
  alias CarPooling.Runs.Queries.GetCarByJourney

  def create_cars(attrs \\ [%{}]) do
    with {_any_qtty, nil} <- clean_up() do
      car_list =
        Enum.map(attrs, fn car ->
          with {:ok, cars} <- create_car(car) do
            cars
          else
            error ->
              error
          end
        end)

      {:ok, car_list}
    else
      _ ->
        {:error, :cannot_clean_up_database}
    end
  end

  def create_journey(attrs \\ %{}) do
    uuid = UUID.uuid4()

    create_journey =
      attrs
      |> assign(:journey_uuid, uuid)
      |> assign_free_car()
      |> CreateJourney.new()

    with :ok <- Router.dispatch(create_journey, consistency: :strong) do
      get(Journey, uuid)
    else
      reply -> reply
    end
  end

  @spec locate_journey(nil | integer) :: nil | {:error, :bad_request}
  def locate_journey(id) when is_integer(id) do
    with %Journey{} <- journey_by_id(id) do
      locate_car =
        id
        |> GetCarByJourney.new()
        |> Repo.one()

      with %Car{} <- locate_car do
        {:ok, locate_car}
      else
        _ ->
          {:ok, :waiting_car}
      end
    else
      _ ->
        {:error, :group_not_found}
    end
  end

  def locate_journey(_) do
    {:error, :bad_request}
  end

  @spec dropoff_journey(any) :: :ok | {:error, any}
  def dropoff_journey(id) when is_integer(id) do
    with %Journey{} = journey <- journey_by_id(id) do
      journey
      |> delete_journey()
    else
      _ ->
        {:error, :not_found}
    end
  end

  def dropoff_journey(_) do
    {:error, :bad_request}
  end

  def delete_journey(%Journey{} = journey) do
    delete_journey =
      %DeleteJourney{}
      |> DeleteJourney.assign(journey)

    Router.dispatch(delete_journey, consistency: :strong)
  end

  def create_car(attrs \\ %{}) do
    uuid = UUID.uuid4()

    create_car =
      attrs
      |> assign(:car_uuid, uuid)
      |> CreateCar.new()

    with :ok <- Router.dispatch(create_car, consistency: :strong) do
      get(Car, uuid)
    else
      reply -> reply
    end
  end

  defp clean_up() do
    GetAllCars.new()
    |> Repo.delete_all()
  end

  def car_by_id(nil) do
  end

  def car_by_id(id) do
    id
    |> GetCarById.new()
    |> Repo.one()
  end

  def journey_by_id(id) do
    id
    |> GetJourneyById.new()
    |> Repo.one()
  end

  defp assign_free_car(attrs) do
    desired_seats =
      attrs
      |> Map.get("people")

    if is_integer(desired_seats) do
      with [_ | _] <-
             car_list =
               desired_seats
               |> GetEmptyCars.new()
               |> Repo.all() do
        car_id = car_list |> Enum.at(0) |> Map.get(:id)
        assign(attrs, :car_id, car_id)
      else
        _ ->
          attrs
      end
    else
      attrs
    end
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end

  defp assign(attrs, key, value), do: Map.put(attrs, key, value)
end
