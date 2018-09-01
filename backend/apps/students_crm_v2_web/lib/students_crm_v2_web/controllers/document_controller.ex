defmodule StudentsCrmV2Web.DocumentController do
  use StudentsCrmV2Web, :controller

  action_fallback(StudentsCrmV2Web.FallbackController)

  alias StudentsCrmV2Web.Auth.Guardian.Plug, as: AuthPlug

  def create(conn, %{"kind" => kind, "file" => file}) do
    with author <- AuthPlug.current_resource(conn),
         {:ok, document} <- StudentsCrmV2.create_document(kind, file, author.id, author) do
      render(conn, "show.json-api", data: document)
    end
  end

  def show(conn, %{"id" => id}) do
    with current_user <- AuthPlug.current_resource(conn),
         {:ok, document} <- StudentsCrmV2.show_document(id, current_user) do
      render(conn, "show.json-api", data: document)
    end
  end
end
