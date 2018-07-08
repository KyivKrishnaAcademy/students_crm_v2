defmodule StudentsCrmV2Web.DocumentView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  alias StudentsCrmV2Web.UserView

  attributes([:asset_url, :kind])

  has_one(:user, serializer: UserView, include: false)

  def asset_url(document, _conn) do
    StudentsCrmV2.document_url({document.asset, document}, :original)
  end
end
