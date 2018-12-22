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

  def register(conn, %{"contact" => contact, "newLoginToken" => loginToken}) do
    with {:ok, cached_contact = {type, value}} <- LoginTokenCache.get(loginToken),
         true <- Map.equal?(contact, %{type => value}),
         {:ok, _} <- StudentsCrmV2.register_user_by_contact(cached_contact),
         login_token <- LoginTokenCache.generate(cached_contact) do
      render(conn, "login_token.json", data: login_token)
    else
      {:error, :no_token_found} ->
        send_resp(conn, 498, "")

      err ->
        err
    end
  end

  def generate(conn, params) do
    send_email(params, conn.assigns.tenant.name)
    # send_sms(params)

    send_resp(conn, :ok, "")
  end

  defp send_email(%{"email" => email}, tenant_name) do
    {"email", email}
    |> LoginTokenCache.generate()
    |> LoginTokenEmail.prepare(email, tenant_name)
    |> Mailer.deliver_later()
  end

  defp send_email(_, _), do: nil
end
