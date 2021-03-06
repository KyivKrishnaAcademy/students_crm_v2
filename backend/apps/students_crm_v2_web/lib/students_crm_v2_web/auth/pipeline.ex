defmodule StudentsCrmV2Web.Auth.Pipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline, otp_app: :students_crm_v2_web

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
