defmodule StudentsCrmV2Web do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use StudentsCrmV2Web, :controller
      use StudentsCrmV2Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: StudentsCrmV2Web
      import Plug.Conn
      import StudentsCrmV2Web.Gettext

      alias StudentsCrmV2Web.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/students_crm_v2_web/templates",
        namespace: StudentsCrmV2Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [view_module: 1]
      import StudentsCrmV2Web.UrlHelper, only: [subdomain_root_url: 1, subdomain_root_url: 3]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import StudentsCrmV2Web.ErrorHelpers
      import StudentsCrmV2Web.Gettext

      alias StudentsCrmV2Web.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import StudentsCrmV2Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
