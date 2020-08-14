# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :twitter,
  ecto_repos: [Twitter.Repo]

# Configures the endpoint
config :twitter, TwitterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZcF6o+PZw9WMwdqz/EszojqIVCx4yodoY0/+El1gzlSNIrEDUteXm72dPnZph8Py",
  render_errors: [view: TwitterWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Twitter.PubSub,
  live_view: [signing_salt: "nO95bfvx"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :twitter, Twitter.Guardian,
       issuer: "Twitter",
       secret_key: "0M0WJqywTBiJUS1qvywlIKIAQjKYPvhB+K41Pv+NMGJulhNWqGzgeRK7u9BNfkMg"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
