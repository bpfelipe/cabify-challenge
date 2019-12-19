defmodule CarPoolingWeb.HealthCheckControllerTest do
  use CarPoolingWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "[Health Check]" do
    @tag :web
    test "Health Check to return when server is up", %{conn: conn} do
      conn = get(conn, health_check_path(conn, :health_check))

      json = json_response(conn, 200)["ok"]

      assert json == %{"detail" => "Server is Up!"}
    end
  end
end
