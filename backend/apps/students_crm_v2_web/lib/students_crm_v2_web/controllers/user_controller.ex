defmodule StudentsCrmV2Web.UserController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Auth.Guardian.Plug, as: AuthPlug
  alias StudentsCrmV2Web.CurrentUserView

  def index(conn, params) do
    {data, pagination} =
      params
      |> Map.put("tenant_id", conn.assigns.tenant.id)
      |> StudentsCrmV2.list_users()

    render(conn, "index.json-api", data: data, opts: [meta: pagination])
  end

  def update(conn, %{"data" => %{"attributes" => params}, "id" => user_id}) do
    with author <- AuthPlug.current_resource(conn),
         {:ok, user} <- StudentsCrmV2.update_user(user_id, params, author) do
      conn
      |> put_view(CurrentUserView)
      |> render("show.json-api", data: user)
    end
  end

  def show(conn, %{"id" => user_id}) do
    with {:ok, user} <- StudentsCrmV2.show_user(user_id) do
      render(conn, "show.json-api", data: user)
    end
  end
end
