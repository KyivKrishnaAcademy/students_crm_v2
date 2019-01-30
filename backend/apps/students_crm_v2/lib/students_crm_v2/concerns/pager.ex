defmodule StudentsCrmV2.Concerns.Pager do
  @moduledoc false

  alias Ecto.Query
  alias StudentsCrmV2.Repo

  @spec page(Query.t(), params :: map()) :: {[map()] | no_return(), map()}
  def page(query, params) do
    import Query, only: [limit: 2, offset: 2]

    page_number = page_param(params, "number", "1")
    page_size = page_param(params, "size", "50")
    offset = page_size * (page_number - 1)

    current_page =
      query
      |> limit(^page_size)
      |> offset(^offset)
      |> Repo.all()

    {current_page, %{total: count(query)}}
  end

  defp page_param(params, name, default), do: String.to_integer(get_in(params, ["page", name]) || default)

  defp count(query), do: Repo.aggregate(query, :count, :id) || 0
end
