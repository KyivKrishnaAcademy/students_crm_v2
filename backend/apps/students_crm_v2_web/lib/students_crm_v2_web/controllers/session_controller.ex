defmodule StudentsCrmV2Web.SessionController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Auth.Guardian.Plug, as: AuthPlug

  def post(conn, _params) do
    with user <- AuthPlug.current_resource(conn),
         timestamp <- DateTime.to_unix(DateTime.utc_now(), :microsecond) do
      render(conn, "show.json-api", data: %{id: timestamp, user: user})
    end
  end
end
