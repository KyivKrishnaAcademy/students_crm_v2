defmodule StudentsCrmV2 do
  @moduledoc """
  StudentsCrmV2 keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias StudentsCrmV2.Interactions.{
    Document,
    Tenant,
    User
  }

  alias StudentsCrmV2.Uploaders

  defdelegate create_document(kind, file, user_id, author), to: Document.Create, as: :execute
  defdelegate show_document(id, current_user), to: Document.Show, as: :execute

  defdelegate get_tenant_by_name(name), to: Tenant.GetByName, as: :execute
  defdelegate list_tenants(), to: Tenant.List, as: :execute

  defdelegate adult?(user_or_date), to: User.Adult, as: :execute
  defdelegate agree_to_privacy_policy(id, author), to: User.Agree, as: :execute
  defdelegate get_user_by_contact(contact), to: User.GetByContact, as: :execute
  defdelegate list_users(params), to: User.List, as: :execute
  defdelegate register_user_by_contact(params), to: User.RegisterByContact, as: :execute
  defdelegate show_user(id), to: User.Show, as: :execute
  defdelegate update_user(user_id, params, author), to: User.Update, as: :execute
  defdelegate user_relate_with_tenant(user_id, tenant_id), to: User.RelateWithTenant, as: :execute

  defdelegate document_url(asset, version), to: Uploaders.Document, as: :url
end
