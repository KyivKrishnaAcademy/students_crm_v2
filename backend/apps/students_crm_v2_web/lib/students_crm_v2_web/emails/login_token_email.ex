defmodule StudentsCrmV2Web.LoginTokenEmail do
  @moduledoc false

  use Bamboo.Phoenix, view: StudentsCrmV2Web.EmailView

  def prepare(login_token, address, tenant_name) do
    new_email()
    |> from("robodas@veda-kiev.org.ua")
    |> subject("Ваш код для входу")
    |> put_layout({StudentsCrmV2Web.LayoutView, :email})
    |> to(address)
    |> assign(:login_token, login_token)
    |> assign(:main_title, "Код для входу")
    |> assign(:tenant_name, tenant_name)
    |> render(:login_token)
  end
end
