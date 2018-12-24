defmodule StudentsCrmV2Web.TenantPlug do
  @moduledoc false

  import Plug.Conn, only: [assign: 3, get_req_header: 2, send_resp: 3, halt: 1]

  def init(options), do: options

  def call(conn, _opts), do: conn |> get_req_header("tenant") |> List.first() |> handle(conn)

  defp send_error(conn, msg), do: conn |> send_resp(:bad_request, ~s({error:"#{msg}")) |> halt()

  defp handle(nil, conn), do: send_error(conn, "Tenant header is missing")
  defp handle(tenant_name, conn), do: tenant_name |> StudentsCrmV2.get_tenant_by_name() |> set_tenant(conn)

  defp set_tenant({:error, _}, conn), do: send_error(conn, "Tenant is unknown")
  defp set_tenant({_, tenant}, conn), do: assign(conn, :tenant, tenant)
end
