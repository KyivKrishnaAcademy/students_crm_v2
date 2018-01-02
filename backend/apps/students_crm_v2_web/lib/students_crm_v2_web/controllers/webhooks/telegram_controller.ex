defmodule StudentsCrmV2Web.Webhooks.TelegramController do
  use StudentsCrmV2Web, :controller

  def create(conn, %{"token" => token} = params) do
    if token == Application.get_env(:nadia, :token), do: TelegramBot.dispatch(params)

    send_resp(conn, :no_content, "")
  end
end
