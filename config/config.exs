# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :oauth_test,
  ecto_repos: [OauthTest.Repo]

# Configures the endpoint
config :oauth_test, OauthTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "B5Ajw7jFmQyVhXkYEkXKS0tkRDf7lBJyZQa4HvP0BLEC6C+rRaYSKp3ybfl+3fst",
  render_errors: [view: OauthTestWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: OauthTest.PubSub,
  live_view: [signing_salt: "1iE08sKG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
