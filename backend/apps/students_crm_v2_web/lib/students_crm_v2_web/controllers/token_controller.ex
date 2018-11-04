defmodule StudentsCrmV2Web.TokenController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.{LoginTokenEmail, Mailer}

  def generate(conn, params) do
    send_email(params)
    # send_sms(params)

    send_resp(conn, :ok, "")
  end

  defp send_email(%{"email" => email}) do
    {"email", email}
    |> LoginTokenCache.generate()
    |> LoginTokenEmail.prepare(email)
    |> Mailer.deliver_later()
  end

  defp send_email(_), do: nil
end
