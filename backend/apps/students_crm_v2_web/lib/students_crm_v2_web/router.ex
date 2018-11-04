defmodule StudentsCrmV2Web.Router do
  use StudentsCrmV2Web, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:put_secure_browser_headers)
  end

  pipeline :api_authenticated do
    plug(:accepts, ["json-api", "json"])
    plug(StudentsCrmV2Web.Auth.Pipeline)
    plug(JaSerializer.Deserializer)
  end

  pipeline :api_authenticated_blank do
    plug(:accepts, ["json-api", "json"])
    plug(StudentsCrmV2Web.Auth.BlankPipeline)
    plug(JaSerializer.Deserializer)
  end

  pipeline :api_simple_json do
    plug(:accepts, ["json"])
  end

  scope "/", StudentsCrmV2Web do
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/api/v1", StudentsCrmV2Web, as: :api_v1 do
    pipe_through(:api_authenticated_blank)

    post("/sessions", SessionController, :post)
  end

  scope "/api/v1", StudentsCrmV2Web, as: :api_v1 do
    pipe_through(:api_authenticated)

    resources "/users", UserController, only: [:index, :update] do
      post("/agree", PrivacyAgreementController, :post)
    end

    resources("/documents", DocumentController, only: [:create, :show])
  end

  scope "/api/v1", StudentsCrmV2Web, as: :api_v1 do
    pipe_through(:api_simple_json)

    post("/token-generate", TokenController, :generate)
  end

  if Mix.env() == :dev do
    forward("/sent_emails", Bamboo.SentEmailViewerPlug)
  end
end
