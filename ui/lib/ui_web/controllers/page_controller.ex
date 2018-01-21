defmodule UiWeb.PageController do
  use UiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def hue(conn, _params) do
    bridges = Hue.Bridges.get()
    render(conn, "hue.html", bridges: bridges)
  end

end
