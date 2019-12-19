defmodule CarPoolingWeb.HealthCheckController do
  use CarPoolingWeb, :controller

  action_fallback(CarPoolingWeb.FallbackController)

  def health_check(conn, _anything) do
    conn
    |> put_status(:ok)
    |> render("health_check.json")
  end
end
