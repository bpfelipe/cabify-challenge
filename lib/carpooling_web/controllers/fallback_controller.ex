defmodule CarPoolingWeb.FallbackController do
  use CarPoolingWeb, :controller

  def call(conn, {:error, :validation_failure, errors}) do
    conn
    |> put_status(:bad_request)
    |> put_view(CarPoolingWeb.ValidationView)
    |> render("error.json", errors: errors)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(CarPoolingWeb.ErrorView)
    |> render(:"404")
  end
end
