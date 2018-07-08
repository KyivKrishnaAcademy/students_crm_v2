defmodule StudentsCrmV2Web.UserController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Guardian.Plug, as: GuardianPlug
  alias StudentsCrmV2Web.CurrentUserView

  plug(
    Guardian.Plug.EnsureAuthenticated,
    module: StudentsCrmV2Web.Guardian,
    error_handler: StudentsCrmV2Web.AuthErrorHandler
  )

  def index(conn, _params) do
    render(conn, "index.json-api", data: StudentsCrmV2.list_users())
  end

  def update(conn, %{"data" => %{"attributes" => params}, "id" => user_id}) do
    with author <- GuardianPlug.current_resource(conn),
         {:ok, user} <- StudentsCrmV2.update_user(user_id, params, author) do
      conn
      |> put_view(CurrentUserView)
      |> render("show.json-api", data: user)
    end
  end
end
