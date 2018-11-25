defmodule StudentsCrmV2Web.LoginTokenEmail do
  @moduledoc false

  use Bamboo.Phoenix, view: StudentsCrmV2Web.EmailView

  def prepare(login_token, address) do
    new_email()
    |> from("robodas@veda-kiev.org.ua")
    |> subject("Ваш код для входу")
    |> put_layout({StudentsCrmV2Web.LayoutView, :email})
    |> to(address)
    |> assign(:login_token, login_token)
    |> render(:login_token, main_title: "Код для входу")
  end
end
