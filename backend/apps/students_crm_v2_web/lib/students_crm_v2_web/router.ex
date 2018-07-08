defmodule StudentsCrmV2Web.Router do
  use StudentsCrmV2Web, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json-api", "json"])
    plug(Guardian.Plug.VerifyHeader, module: StudentsCrmV2Web.Guardian)
    plug(Guardian.Plug.LoadResource, module: StudentsCrmV2Web.Guardian, allow_blank: true)
    plug(JaSerializer.Deserializer)
  end

  pipeline :webhooks do
    plug(:accepts, ["json"])
  end

  scope "/", StudentsCrmV2Web do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/api/v1", StudentsCrmV2Web, as: :api_v1 do
    pipe_through(:webhooks)

    scope "/webhooks", Webhooks, as: :webhooks do
      post("/telegram/:token", TelegramController, :create)
    end
  end

  scope "/api/v1", StudentsCrmV2Web, as: :api_v1 do
    pipe_through(:api)

    get("/users/me", CurrentUserController, :show)

    resources "/users", UserController, only: [:index, :update] do
      post("/agree", PrivacyAgreementController, :post)
    end

    resources("/documents", DocumentController, only: [:create, :show])
    resources("/login", LoginController, only: [:create])
  end
end
