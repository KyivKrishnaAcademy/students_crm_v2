defmodule StudentsCrmV2Web.TokenController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Auth.Guardian
  alias StudentsCrmV2Web.{LoginTokenEmail, Mailer}

  def exchange(conn, %{"loginToken" => loginToken}) do
    cached_contact = LoginTokenCache.get(loginToken)

    with {:ok, contact} <- cached_contact,
         {:ok, user} <- StudentsCrmV2.get_user_by_contact(contact),
         {:ok, jwt_token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "exchange.json", data: jwt_token)
    else
      {:error, :no_user_found} ->
        {:ok, contact} = cached_contact
        data = %{token: LoginTokenCache.generate(contact), contact: contact}

        conn |> put_status(:not_found) |> render("new_login_token.json", data: data)

      {:error, :no_token_found} ->
        send_resp(conn, 498, "")

      err ->
        err
    end
  end

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
