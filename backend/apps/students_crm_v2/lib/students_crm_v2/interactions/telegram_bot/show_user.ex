defmodule StudentsCrmV2.Interactions.TelegramBot.ShowUser do
  @moduledoc false

  alias StudentsCrmV2.Repo

  import Ecto.Query, only: [join: 5, where: 3, select: 3]

  def execute(uid) do
    "phones"
    |> join(:inner, [p], u in "users", p.user_id == u.id)
    |> where([p, u], p.telegram_uid == type(^uid, :integer))
    |> select([p, u], %{"locale" => u.locale, "phone" => p.phone, "uid" => type(^uid, :integer), "id" => u.id})
    |> Repo.one()
  end
end
