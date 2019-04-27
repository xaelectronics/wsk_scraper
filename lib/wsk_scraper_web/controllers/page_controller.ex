defmodule WskScraperWeb.PageController do
  use WskScraperWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
