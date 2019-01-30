defmodule StudentsCrmV2Web.AcademicGroupController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  def index(conn, params) do
    {data, pagination} =
      params
      |> Map.put("tenant_id", conn.assigns.tenant.id)
      |> StudentsCrmV2.list_academic_groups()

    render(conn, "index.json-api", data: data, opts: [meta: pagination])
  end
end
