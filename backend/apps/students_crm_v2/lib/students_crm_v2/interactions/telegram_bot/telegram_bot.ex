defmodule StudentsCrmV2.Interactions.TelegramBot do
  @moduledoc false

  alias StudentsCrmV2.Interactions.TelegramBot.{
    Start,
  }

  def dispatch(%{"message" => %{"text" => "/start"}} = params), do: Start.execute(params)

  def dispatch(params) do
    require Logger

    Logger.info(fn -> "Dunno how to handle telegram webhook #{inspect(params)}" end)
  end
end
