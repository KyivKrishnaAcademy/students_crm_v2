defmodule LoginTokenCache.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {ConCache,
       [
         name: :login_token_cache,
         ttl_check_interval: :timer.hours(1),
         global_ttl: :timer.hours(24),
         touch_on_read: false
       ]}
      # Starts a worker by calling: LoginTokenCache.Worker.start_link(arg)
      # {LoginTokenCache.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LoginTokenCache.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
