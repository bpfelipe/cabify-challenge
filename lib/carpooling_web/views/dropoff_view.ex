defmodule CarPoolingWeb.DropOffView do
  use CarPoolingWeb, :view
  alias CarPoolingWeb.DropOffView

  def render("ok.json", _assign) do
    %{ok: %{detail: "The group dropped off successfully!"}}
  end

  def render("no_content.json", _assigns) do
    %{ok: %{detail: "The group is waiting for an available car"}}
  end

  def render("not_found.json", _assigns) do
    %{errors: %{detail: "Group not found"}}
  end

  def render("bad_request.json", _assigns) do
    %{errors: %{detail: "Bad Request"}}
  end
end
