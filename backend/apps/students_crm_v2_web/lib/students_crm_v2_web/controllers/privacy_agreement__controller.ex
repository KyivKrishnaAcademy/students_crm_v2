defmodule StudentsCrmV2Web.PrivacyAgreementController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Guardian.Plug, as: GuardianPlug
  alias StudentsCrmV2Web.CurrentUserView

  plug(
    Guardian.Plug.EnsureAuthenticated,
    module: StudentsCrmV2Web.Guardian,
    error_handler: StudentsCrmV2Web.AuthErrorHandler
  )

  def post(conn, %{"user_id" => user_id}) do
    with author <- GuardianPlug.current_resource(conn),
         {:ok, user} <- StudentsCrmV2.agree_to_privacy_policy(user_id, author) do
      conn
      |> put_view(CurrentUserView)
      |> render("show.json-api", data: user)
    end
  end
end
