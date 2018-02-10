defmodule StudentsCrmV2Web.Guardian do
  use Guardian, otp_app: :students_crm_v2_web

  alias StudentsCrmV2.Models.User

  def subject_for_token(%User{id: user_id}, _claims), do: {:ok, to_string(user_id)}
  def subject_for_token(_, _), do: {:error, "there is no user"}

  def resource_from_claims(%{"sub" => user_id}), do: {:ok, StudentsCrmV2.show_user(user_id)}
  def resource_from_claims(_claims), do: {:error, "there is no user"}
end
