defmodule StudentsCrmV2Web.PageView do
  use StudentsCrmV2Web, :view

  def tenant_root_url(tenant) do
    %{host: host, protocol: protocol} = Application.get_env(:students_crm_v2_web, :urls)

    "#{protocol}://#{tenant.name}.#{host}"
  end
end
