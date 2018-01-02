defmodule StudentsCrmV2.Application do
  @moduledoc """
  The StudentsCrmV2 Application Service.

  The students_crm_v2 system business domain lives in this application.

  Exposes API to clients such as the `StudentsCrmV2Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(StudentsCrmV2.Repo, []),
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: StudentsCrmV2.Supervisor)
  end
end
