defmodule UiWeb.Router do
  use UiWeb, :router

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

  scope "/", UiWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hue", PageController, :hue
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: UiWeb.Schema,
      interface: :simple,
      context: %{pubsub: UiWeb.Endpoint}

    forward "/", Absinthe.Plug,
      schema: UiWeb.Schema
  end

end
