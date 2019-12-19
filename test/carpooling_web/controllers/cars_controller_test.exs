defmodule CarPoolingWeb.CarControllerTest do
  use CarPoolingWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "[Create Cars]" do
    @tag :web
    test "Create car list and delete existing ones when data is valid", %{conn: conn} do
      conn = put(conn, car_path(conn, :create), _json: build_list(3, :car))

      assert json_response(conn, 200)
    end

    # TODO Fix when receive answer about car creation
    # @tag :web
    # test "Renders errors when data is invalid", %{conn: conn} do
    #   conn = put(conn, car_path(conn, :create), _json: build_list(3, :car, seats: 7))

    #   assert json_response(conn, 400)["errors"] == %{
    #            "seats" => [
    #              "invalid seats number"
    #            ]
    #          }
    # end

    # @tag :web
    # test "Should not create cars when two cars has same id", %{conn: conn} do
    #   conn = put(conn, car_path(conn, :create), _json: build_list(3, :car, id: 1))

    #   assert json_response(conn, 400)["errors"] == %{
    #            "id" => [
    #              "has already been taken"
    #            ]
    #          }
    # end
  end
end
