defmodule StudentsCrmV2.Uploaders.Document do
  @moduledoc false

  use Arc.Definition
  use Arc.Ecto.Definition

  @acl :public_read
  @versions [:original]

  def storage_dir(_, {_, %{id: id}}), do: "uploads/documents/#{id}"

  def filename(version, {_, %{kind: kind}}), do: "#{version}_#{kind}"
end
