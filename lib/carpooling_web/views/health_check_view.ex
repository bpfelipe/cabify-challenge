defmodule CarPoolingWeb.HealthCheckView do
  use CarPoolingWeb, :view
  alias CarPoolingWeb.HealthCheckView

  def render("health_check.json", _assigns) do
    %{ok: %{detail: "Server is Up!"}}
  end
end
