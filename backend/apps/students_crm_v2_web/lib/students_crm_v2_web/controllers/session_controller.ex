defmodule StudentsCrmV2Web.SessionController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2Web.Auth.Guardian.Plug, as: AuthPlug

  def post(conn, _params) do
    timestamp = DateTime.to_unix(DateTime.utc_now(), :microsecond)

    case AuthPlug.current_resource(conn) do
      user = %User{} ->
        render(conn, "show.json-api", data: %{id: timestamp, user: user})

      _ ->
        with claims <- AuthPlug.current_claims(conn),
             {:ok, user = %User{}} <- StudentsCrmV2.register_user(claims) do
          render(conn, "show.json-api", data: %{id: timestamp, user: user})
        end
    end
  end
end
