defmodule WskScraperWeb.Router do
  use WskScraperWeb, :router

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

  scope "/", WskScraperWeb do
    pipe_through :browser

    get "/", PageController, :index
    # resources "/dff", DailyFantasyFuelController
    get "/dff/:betting_site/:date", DailyFantasyFuelController, :index
    get "/csv/dff/:betting_site/:date", DailyFantasyFuelController, :csv
    get "/dff/initialize", DailyFantasyFuelController, :initialize
  end

  # Other scopes may use custom stacks.
  # scope "/api", WskScraperWeb do
  #   pipe_through :api
  # end
end
