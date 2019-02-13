defmodule StudentsCrmV2Web.GroupParticipationController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Auth.Guardian.Plug, as: AuthPlug

  def index(conn, params) do
    params_with_tenant_id = Map.put(params, "tenant_id", conn.assigns.tenant.id)

    with author <- AuthPlug.current_resource(conn),
         {:ok, group_participations} <- StudentsCrmV2.list_group_participations(params_with_tenant_id, author) do
      render(conn, "index.json-api", data: group_participations)
    end
  end
end
