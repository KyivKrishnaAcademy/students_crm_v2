defmodule StudentsCrmV2Web.AcademicGroupController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Auth.Guardian.Plug, as: AuthPlug

  def index(conn, params) do
    {data, pagination} =
      params
      |> Map.put("tenant_id", conn.assigns.tenant.id)
      |> StudentsCrmV2.list_academic_groups()

    render(conn, "index.json-api", data: data, opts: [meta: pagination])
  end

  def show(conn, %{"id" => academic_group_id}) do
    with {:ok, academic_group} <- StudentsCrmV2.show_academic_group(academic_group_id) do
      render(conn, "show.json-api", data: academic_group)
    end
  end

  def create(conn, params) do
    with author <- AuthPlug.current_resource(conn),
         attributes <- get_in(params, ["data", "attributes"]) || %{},
         attributes_with_tenant_id <- Map.put(attributes, "tenant_id", conn.assigns.tenant.id),
         {:ok, user} <- StudentsCrmV2.create_academic_group(attributes_with_tenant_id, author) do
      render(conn, "show.json-api", data: user)
    end
  end
end
