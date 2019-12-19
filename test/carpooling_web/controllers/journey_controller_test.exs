defmodule CarPoolingWeb.JourneyControllerTest do
  use CarPoolingWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "[Create Journey]" do
    @tag :web
    test "Create journey when data is valid", %{conn: conn} do
      cars = build_list(1, :car)
      journey = build(:journey)

      conn = put(conn, car_path(conn, :create), _json: cars)
      conn = post(conn, journey_path(conn, :create), journey: journey)

      json = json_response(conn, 200)["journey"]
      car_id = cars |> Enum.at(0) |> Map.get(:id)
      inserted_at = json["inserted_at"]

      assert json == %{
               "car_id" => car_id,
               "id" => journey.id,
               "inserted_at" => inserted_at,
               "people" => journey.people
             }
    end

    @tag :web
    test "Renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, journey_path(conn, :create), journey: build(:journey, people: 8))

      assert json_response(conn, 400)["errors"] == %{
               "people" => [
                 "must be a number less than or equal to 6"
               ]
             }
    end

    @tag :web
    test "Should not create journey when two journeys has same id", %{conn: conn} do
      conn = post(conn, journey_path(conn, :create), journey: build(:journey, id: 1))

      conn = post(conn, journey_path(conn, :create), journey: build(:journey, id: 1))

      assert json_response(conn, 400)["errors"] == %{
               "id" => [
                 "has already been taken"
               ]
             }
    end
  end
end
