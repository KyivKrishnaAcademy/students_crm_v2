defmodule StudentsCrmV2Web.Auth.Guardian do
  @moduledoc false

  use Guardian, otp_app: :students_crm_v2_web

  alias StudentsCrmV2.Models.User

  def subject_for_token(%User{id: user_id}, _claims), do: {:ok, to_string(user_id)}
  def subject_for_token(_, _), do: {:error, :unauthorized}

  def resource_from_claims(%{"sub" => sub}), do: {:ok, StudentsCrmV2.show_user(sub)}
  def resource_from_claims(_claims), do: {:error, :unauthorized}
end
