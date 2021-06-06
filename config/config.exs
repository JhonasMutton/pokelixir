# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pokelixir,
  ecto_repos: [Pokelixir.Repo]

# Configures the endpoint
config :pokelixir, PokelixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vghPZG3SoPGPs7Pr+xT9j9XauCEYQOUVHpoDV08sYdD8QSPaAkh3P2ujy8I0wMsH",
  render_errors: [view: PokelixirWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pokelixir.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "nzOlZdJ7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
