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

  def create(
        conn,
        %{
          "data" => %{
            "relationships" => %{
              "academic_group" => %{"data" => %{"id" => academic_group_id}},
              "user" => %{"data" => %{"id" => user_id}}
            }
          }
        }
      ) do
    attributes = %{
      "academic_group_id" => academic_group_id,
      "tenant_id" => conn.assigns.tenant.id,
      "user_id" => user_id
    }

    with author <- AuthPlug.current_resource(conn),
         {:ok, group_participation} <- StudentsCrmV2.create_group_participation(attributes, author) do
      render(conn, "show.json-api", data: group_participation)
    end
  end

  def delete(conn, %{"id" => group_participation_id}) do
    with {:ok, _} <- StudentsCrmV2.delete_group_participation(group_participation_id) do
      send_resp(conn, :no_content, "")
    end
  end

  def remove_from_group(conn, %{"group_participation_id" => group_participation_id}) do
    with author <- AuthPlug.current_resource(conn),
         {:ok, group_participation} <- StudentsCrmV2.remove_from_group(group_participation_id, author) do
      render(conn, "show.json-api", data: group_participation)
    end
  end
end
