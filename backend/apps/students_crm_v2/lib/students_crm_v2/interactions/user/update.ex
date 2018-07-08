defmodule StudentsCrmV2.Interactions.User.Update do
  @moduledoc false

  alias Ecto.Changeset
  alias StudentsCrmV2.Models.User
  alias StudentsCrmV2.Repo

  @fields [:birthday, :display_name, :gender]

  @spec execute(id :: String.t(), params :: map(), author :: User.t()) :: {:ok, User.t()} | {:error, :unauthorized}
  def execute(id, params, author) do
    id
    |> String.to_integer
    |> authorize(author)
    |> update_user(params)
  end

  defp authorize(user_id, user = %User{id: author_id}) when user_id == author_id, do: {:ok, user}
  defp authorize(_, _), do: {:error, :unauthorized}

  defp update_user({:ok, user}, params), do: user |> Changeset.cast(params, @fields) |> validate |> Repo.update
  defp update_user(error, _), do: error

  defp validate(changeset) do
    import Changeset, only: [validate_required: 2, validate_inclusion: 3]

    changeset
    |> validate_required(@fields)
    |> validate_inclusion(:gender, ~w[male female])
    |> validate_birthday
  end

  defp validate_birthday(changeset) do
    case Changeset.fetch_field(changeset, :birthday) do
      {_, date} ->
        if Timex.today |> Timex.shift(years: -10) |> Timex.after?(date) do
          changeset
        else
          Changeset.add_error(changeset, :birthday, "Should be more than 10 years ago")
        end
      _ ->
        changeset
    end
  end
end
