defmodule StudentsCrmV2Web.UserView do
  use StudentsCrmV2Web, :view
  use JaSerializer.PhoenixView

  attributes([
    :birthday,
    :complex_name,
    :display_name,
    :gender,
    :locale
  ])
end
