defmodule StudentsCrmV2Web.LoginView do
  use StudentsCrmV2Web, :view

  def render("show_token.json", %{auth_token: auth_token}) when is_bitstring(auth_token), do: %{auth_token: auth_token}
end
