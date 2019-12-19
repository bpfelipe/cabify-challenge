defmodule CarPoolingWeb.DropOffControllerTest do
  use CarPoolingWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "[DropOff]" do
    @tag :web
    test "DropOff group when data is valid", %{conn: conn} do
      # Build List of available Cars
      conn = put(conn, car_path(conn, :create), _json: build_list(6, :car))

      # Build Journeys
      journey_to_dropoff = build(:journey)
      conn = post(conn, journey_path(conn, :create), journey: journey_to_dropoff)

      # Dropoff group
      conn = post(conn, drop_off_path(conn, :dropoff), %{"ID" => journey_to_dropoff.id})

      json = json_response(conn, 200)["ok"]

      assert json == %{"detail" => "The group dropped off successfully!"}
    end

    @tag :web
    test "Render Error 404 when group is not found", %{conn: conn} do
      # Build List of available Cars
      conn = put(conn, car_path(conn, :create), _json: build_list(6, :car))

      # Build Journeys
      conn = post(conn, journey_path(conn, :create), journey: build(:journey))

      # Dropoff group
      conn = post(conn, drop_off_path(conn, :dropoff), %{"ID" => 1})

      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Group not found"}}
    end

    @tag :web
    test "Render Error 400 when request is invalid", %{conn: conn} do
      # Build List of available Cars
      conn = put(conn, car_path(conn, :create), _json: build_list(6, :car))

      # Build Journeys
      conn = post(conn, journey_path(conn, :create), journey: build(:journey))

      # Dropoff group
      conn = post(conn, drop_off_path(conn, :dropoff), %{"ID" => "aa"})

      json = json_response(conn, 400)

      assert json == %{"errors" => %{"detail" => "Bad Request"}}
    end
  end
end
