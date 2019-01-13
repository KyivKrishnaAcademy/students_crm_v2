defmodule StudentsCrmV2.Interactions.User.Update do
  @moduledoc false

  alias Ecto.Changeset
  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2.Repo

  @fields ~w[
    birthday display_name education favorite_lectots gender locale marital_status middle_name name surname work
  ]a

  @required_fields ~w[birthday gender name surname]a

  @spec execute(id :: String.t(), params :: map(), author :: User.t()) :: {:ok, User.t()} | {:error, :unauthorized}
  def execute(id, params, author) do
    id
    |> String.to_integer()
    |> authorize(author)
    |> update_user(params)
  end

  defp authorize(user_id, user = %User{id: author_id}) when user_id == author_id, do: {:ok, user}
  defp authorize(_, _), do: {:error, :unauthorized}

  defp update_user({:ok, user}, params), do: user |> Changeset.cast(params, @fields) |> validate |> Repo.update()
  defp update_user(error, _), do: error

  defp validate(changeset) do
    import Changeset, only: [validate_required: 2, validate_inclusion: 3]

    changeset
    |> set_complex_name()
    |> validate_required(@required_fields)
    |> validate_inclusion(:gender, User.genders())
    |> validate_inclusion(:marital_status, User.marital_statuses())
    |> validate_inclusion(:privacy_agreed, [true])
    |> validate_birthday
  end

  defp validate_birthday(changeset) do
    case Changeset.fetch_field(changeset, :birthday) do
      {_, date} ->
        if StudentsCrmV2.adult?(date) do
          changeset
        else
          Changeset.add_error(changeset, :birthday, "Should be more than 16 years ago")
        end

      _ ->
        changeset
    end
  end

  defp set_complex_name(changeset) do
    import Changeset, only: [change: 2]

    name = get_trimmed_string(changeset, :name)
    surname = get_trimmed_string(changeset, :surname)
    middle_name = get_trimmed_string(changeset, :middle_name)
    display_name = get_trimmed_string(changeset, :display_name)
    civil_name = "#{surname} #{name}"
    civil_name = if String.length(middle_name) > 0, do: "#{civil_name} #{String.trim(middle_name)}", else: civil_name
    complex_name = if String.length(display_name) > 0, do: "#{display_name} (#{civil_name})", else: civil_name

    change(changeset, complex_name: complex_name)
  end

  defp get_trimmed_string(changeset, field_name) do
    import Changeset, only: [get_field: 3]

    changeset |> get_field(field_name, "") |> String.trim()
  end
end
