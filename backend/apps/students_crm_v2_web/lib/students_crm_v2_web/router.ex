defmodule StudentsCrmV2Web.Router do
  use StudentsCrmV2Web, :router

  alias StudentsCrmV2Web.TenantPlug

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:put_secure_browser_headers)
  end

  pipeline :api_authenticated do
    plug(:accepts, ["json-api", "json"])
    plug(StudentsCrmV2Web.Auth.Pipeline)
    plug(JaSerializer.Deserializer)
    plug(TenantPlug)
  end

  pipeline :api_simple_json do
    plug(:accepts, ["json"])
    plug(TenantPlug)
  end

  scope "/", StudentsCrmV2Web do
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/api/v1", StudentsCrmV2Web, as: :api_v1 do
    pipe_through(:api_authenticated)

    resources "/academic_groups", AcademicGroupController, only: [:index]

    resources "/users", UserController, only: [:index, :update, :show, :delete] do
      post("/agree", PrivacyAgreementController, :post)
    end

    resources("/documents", DocumentController, only: [:create, :show])

    post("/sessions", SessionController, :post)
  end

  scope "/api/v1", StudentsCrmV2Web, as: :api_v1 do
    pipe_through(:api_simple_json)

    post("/token-auth", TokenController, :exchange)
    post("/token-generate", TokenController, :generate)
    post("/token-register", TokenController, :register)
  end

  if Mix.env() == :dev do
    forward("/sent_emails", Bamboo.SentEmailViewerPlug)
  end
end
