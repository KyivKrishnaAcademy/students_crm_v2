defmodule StudentsCrmV2 do
  @moduledoc """
  StudentsCrmV2 keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias StudentsCrmV2.Interactions.{
    AcademicGroup,
    Document,
    GroupParticipation,
    Tenant,
    User
  }

  alias StudentsCrmV2.Uploaders

  defdelegate create_academic_group(params, author), to: AcademicGroup.Create, as: :execute
  defdelegate delete_academic_group(id), to: AcademicGroup.Delete, as: :execute
  defdelegate list_academic_groups(params), to: AcademicGroup.List, as: :execute
  defdelegate show_academic_group(id), to: AcademicGroup.Show, as: :execute
  defdelegate update_academic_group(id, params, author), to: AcademicGroup.Update, as: :execute

  defdelegate create_document(kind, file, user_id, author), to: Document.Create, as: :execute
  defdelegate show_document(id, current_user), to: Document.Show, as: :execute

  defdelegate create_group_participation(params, author), to: GroupParticipation.Create, as: :execute
  defdelegate delete_group_participation(id), to: GroupParticipation.Delete, as: :execute
  defdelegate list_group_participations(params, author), to: GroupParticipation.List, as: :execute

  defdelegate get_tenant_by_name(name), to: Tenant.GetByName, as: :execute
  defdelegate list_tenants(), to: Tenant.List, as: :execute

  defdelegate adult?(user_or_date), to: User.Adult, as: :execute
  defdelegate agree_to_privacy_policy(id, author), to: User.Agree, as: :execute
  defdelegate delete_user(id), to: User.Delete, as: :execute
  defdelegate get_user_by_contact(contact), to: User.GetByContact, as: :execute
  defdelegate list_users(params), to: User.List, as: :execute
  defdelegate register_user_by_contact(params), to: User.RegisterByContact, as: :execute
  defdelegate show_user(id), to: User.Show, as: :execute
  defdelegate update_user(user_id, params, author), to: User.Update, as: :execute
  defdelegate user_relate_with_tenant(user_id, tenant_id), to: User.RelateWithTenant, as: :execute

  defdelegate document_url(asset, version), to: Uploaders.Document, as: :url
end
