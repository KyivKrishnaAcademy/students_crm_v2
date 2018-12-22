defmodule StudentsCrmV2Web.UrlHelper do
  def subdomain_root_url(subdomain), do: subdomain_root_url(subdomain, nil, %{})

  def subdomain_root_url(subdomain, path, query_params) do
    url_params = Application.get_env(:students_crm_v2_web, :url_params)

    %URI{struct(URI, url_params) | host: "#{subdomain}.#{url_params[:host]}", path: path}
    |> StudentsCrmV2Web.Router.Helpers.page_url(:index, query_params)
    |> String.trim_trailing("/")
    |> String.replace("/?", "?")
  end
end
