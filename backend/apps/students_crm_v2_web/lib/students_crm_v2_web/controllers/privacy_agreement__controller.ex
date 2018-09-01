defmodule StudentsCrmV2Web.PrivacyAgreementController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Auth.Guardian.Plug, as: AuthPlug
  alias StudentsCrmV2Web.CurrentUserView

  def post(conn, %{"user_id" => user_id}) do
    with author <- AuthPlug.current_resource(conn),
         {:ok, user} <- StudentsCrmV2.agree_to_privacy_policy(user_id, author) do
      conn
      |> put_view(CurrentUserView)
      |> render("show.json-api", data: user)
    end
  end
end
