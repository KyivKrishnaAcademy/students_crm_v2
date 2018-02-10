defmodule StudentsCrmV2Web.LoginController do
  use StudentsCrmV2Web, :controller

  action_fallback StudentsCrmV2Web.FallbackController

  alias StudentsCrmV2Web.Guardian

  def create(conn, %{"token" => token}) do
    with  user <- StudentsCrmV2.login_by_token(token),
          {:ok, auth_token, claims} <- Guardian.encode_and_sign(user)
    do
      render(conn, "show_token.json", auth_token: auth_token)
    end
  end
end
