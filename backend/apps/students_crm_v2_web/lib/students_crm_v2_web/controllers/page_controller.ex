defmodule StudentsCrmV2Web.PageController do
  use StudentsCrmV2Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
