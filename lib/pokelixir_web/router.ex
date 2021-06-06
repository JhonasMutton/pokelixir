
defmodule PokelixirWeb.Router do
  use PokelixirWeb, :router

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

  scope "/", PokelixirWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/pokemons", PokemonController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PokelixirWeb do
  #   pipe_through :api
  # end
end
