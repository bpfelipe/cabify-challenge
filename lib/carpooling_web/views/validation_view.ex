defmodule CarPoolingWeb.ValidationView do
  use CarPoolingWeb, :view

  def render("error.json", %{errors: errors}) do
    %{errors: errors}
  end
end
