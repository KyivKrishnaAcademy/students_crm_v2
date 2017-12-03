defmodule StudentsCrmV2.Interactions.TelegramBot.Start do
  @moduledoc false

  def execute(%{"message" => %{"from" => %{"id" => user_id}}}) do
    Nadia.send_message(user_id, "Hello there")
  end
end
