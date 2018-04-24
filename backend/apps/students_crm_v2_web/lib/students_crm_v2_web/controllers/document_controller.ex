defmodule StudentsCrmV2Web.DocumentController do
  use StudentsCrmV2Web, :controller

  action_fallback StudentsCrmV2Web.FallbackController

  alias StudentsCrmV2Web.Guardian.Plug, as: GuardianPlug

  plug Guardian.Plug.EnsureAuthenticated,
    module: StudentsCrmV2Web.Guardian,
    error_handler: StudentsCrmV2Web.AuthErrorHandler

  def create(
    conn,
    %{"data" => %{"attributes" => %{"kind" => kind}, "relationships" => %{"user" => %{"data" => %{"id" => user_id}}}}}
  ) do
    with  author <- GuardianPlug.current_resource(conn),
          {:ok, document} <- StudentsCrmV2.create_document(kind, user_id, author)
    do
      render(conn, "show.json-api", data: document)
    end
  end

  def show(conn, %{"id" => id}) do
    with  current_user <- GuardianPlug.current_resource(conn),
          {:ok, document} <- StudentsCrmV2.show_document(id, current_user)
    do
      render(conn, "show.json-api", data: document)
    end
  end
end
