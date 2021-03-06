defmodule StudentsCrmV2Web.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common datastructures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import StudentsCrmV2Web.Router.Helpers

      # The default endpoint for testing
      @endpoint StudentsCrmV2Web.Endpoint
    end
  end

  alias Ecto.Adapters.SQL.Sandbox
  alias Phoenix.ConnTest

  setup tags do
    :ok = Sandbox.checkout(StudentsCrmV2.Repo)

    unless tags[:async] do
      Sandbox.mode(StudentsCrmV2.Repo, {:shared, self()})
    end

    {:ok, conn: ConnTest.build_conn()}
  end
end
