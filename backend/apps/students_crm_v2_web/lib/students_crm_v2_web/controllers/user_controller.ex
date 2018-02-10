defmodule StudentsCrmV2Web.UserController do
  use StudentsCrmV2Web, :controller

  action_fallback StudentsCrmV2Web.FallbackController

  plug Guardian.Plug.EnsureAuthenticated,
    module: StudentsCrmV2Web.Guardian,
    error_handler: StudentsCrmV2Web.AuthErrorHandler

  def index(conn, _params) do
    render(conn, "index.json-api", data: StudentsCrmV2.list_users())
  end
end
