defmodule StudentsCrmV2Web.LoginTokenEmail do
  @moduledoc false

  import Bamboo.Email

  def prepare(login_token, address) do
    new_email()
    |> to(address)
    |> from("robodas@veda-kiev.org.ua")
    |> subject("Your login token!!!")
    |> html_body("<strong>#{login_token}</strong>")
    |> text_body(login_token)
  end
end
