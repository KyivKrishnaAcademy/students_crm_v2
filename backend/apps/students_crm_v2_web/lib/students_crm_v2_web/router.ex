defmodule StudentsCrmV2Web.Router do
  use StudentsCrmV2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :webhooks do
    plug :accepts, ["json"]
  end

  scope "/", StudentsCrmV2Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api/v1", StudentsCrmV2Web, as: :api_v1 do
    pipe_through :webhooks

    scope "/webhooks", Webhooks, as: :webhooks do
      post "/telegram/:token", TelegramController, :create
    end
  end
end
