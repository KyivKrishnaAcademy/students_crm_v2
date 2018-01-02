defmodule TelegramBot.Application do
  @moduledoc """
  The TelegramBot Application Service.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(
        ConCache,
        [
          [
            ttl: :timer.hours(48),
            ttl_check: :timer.seconds(10),
            touch_on_read: true
          ],
          [
            name: :crm_cache,
          ]
        ]
      ),
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: TelegramBot.Supervisor)
  end
end
