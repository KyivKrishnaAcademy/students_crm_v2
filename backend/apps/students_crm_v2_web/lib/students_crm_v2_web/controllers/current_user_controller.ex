defmodule StudentsCrmV2Web.CurrentUserController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Guardian.Plug, as: GuardianPlug

  plug(
    Guardian.Plug.EnsureAuthenticated,
    module: StudentsCrmV2Web.Guardian,
    error_handler: StudentsCrmV2Web.AuthErrorHandler
  )

  def show(conn, _params) do
    with user <- GuardianPlug.current_resource(conn) do
      render(conn, "show.json-api", data: user)
    end
  end
end
