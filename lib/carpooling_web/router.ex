defmodule CarPoolingWeb.Router do
  use CarPoolingWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", CarPoolingWeb do
    pipe_through(:api)

    put("/cars", CarController, :create)

    post("/journey", JourneyController, :create)

    post("/dropoff", DropOffController, :dropoff)

    post("/locate", LocateController, :locate)

    get("/status", HealthCheckController, :health_check)
  end
end
