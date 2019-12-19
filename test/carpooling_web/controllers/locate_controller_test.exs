defmodule CarPoolingWeb.LocateControllerTest do
  use CarPoolingWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "[Locate]" do
    @tag :web
    test "Locate group, render car and code 200 when data is valid", %{conn: conn} do
      # Build List of available Cars
      car_list = build_list(1, :car)
      conn = put(conn, car_path(conn, :create), _json: car_list)

      # Build Journeys
      journey_to_locate = build(:journey)
      conn = post(conn, journey_path(conn, :create), journey: journey_to_locate)

      # Locate group
      conn = post(conn, locate_path(conn, :locate), %{"ID" => journey_to_locate.id})

      json = json_response(conn, 200)

      car = car_list |> Enum.at(0)

      assert json == %{
               "id" => car.id,
               "seats" => car.seats
             }
    end

    @tag :web
    test "Render 204 when group is waiting for an available car", %{conn: conn} do
      conn = put(conn, car_path(conn, :create), _json: build_list(1, :car))
      conn = post(conn, journey_path(conn, :create), journey: build(:journey))

      journey = build(:journey)
      conn = post(conn, journey_path(conn, :create), journey: journey)

      json = json_response(conn, 200)["journey"]

      assert json == %{
               "car_id" => nil,
               "id" => journey.id,
               "inserted_at" => json["inserted_at"],
               "people" => journey.people
             }

      # Locate group
      conn = post(conn, locate_path(conn, :locate), %{"ID" => journey.id})
      json = json_response(conn, 204)["ok"]

      assert json == %{"detail" => "The group is waiting for an available car"}
    end

    @tag :web
    test "Render Error 404 when group is not found", %{conn: conn} do
      # Build List of available Cars
      conn = put(conn, car_path(conn, :create), _json: build_list(1, :car))

      # Build Journeys
      conn = post(conn, journey_path(conn, :create), journey: build(:journey))
      journey_to_locate = build(:journey)

      # Locate group
      conn = post(conn, locate_path(conn, :locate), %{"ID" => journey_to_locate.id})
      json = json_response(conn, 404)["errors"]

      assert json == %{"detail" => "Group not found"}
    end
  end
end
