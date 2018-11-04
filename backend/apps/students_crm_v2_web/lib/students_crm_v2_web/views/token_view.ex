defmodule StudentsCrmV2Web.TokenView do
  use StudentsCrmV2Web, :view

  def render("exchange.json", %{data: token}), do: %{token: token}

  def render("new_login_token.json", %{data: %{token: token, contact: {type, value}}}) do
    %{
      newLoginToken: token,
      contact: %{type => value}
    }
  end
end
