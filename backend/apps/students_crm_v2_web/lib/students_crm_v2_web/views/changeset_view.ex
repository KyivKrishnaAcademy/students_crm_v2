defmodule StudentsCrmV2Web.ChangesetView do
  use StudentsCrmV2Web, :view

  alias Ecto.Changeset
  alias JaSerializer.Formatter.Utils

  def json_api_error_element({key, msgs}) do
    Enum.map(msgs, fn msg ->
      %{
        "detail" => msg,
        "source" => %{"pointer" => "data/attributes/#{Utils.format_key(key)}"}
      }
    end)
  end

  @doc """
  Traverses and translates changeset errors.

  See `Ecto.Changeset.traverse_errors/2` and
  `StudentsCrmV2Web.ErrorHelpers.translate_error/1` for more details.
  """
  def translate_errors(changeset) do
    changeset
    |> Changeset.traverse_errors(&translate_error/1)
    |> Enum.map(&json_api_error_element/1)
    |> List.flatten()
  end

  def render("error.json-api", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: translate_errors(changeset)}
  end
end
