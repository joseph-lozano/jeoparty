defmodule Jeoparty.Web.Router do
  use Jeoparty.Web, :router

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

  scope "/", Jeoparty.Web do
    pipe_through :browser # Use the default browser stack

    get "/", GameController, :index
    get "/:game_id", GameController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", Jeoparty do
  #   pipe_through :api
  # end
end
