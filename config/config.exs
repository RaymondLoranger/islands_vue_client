# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :islands_vue_client,
  namespace: Islands.Vue.Client

# Configures the endpoint
config :islands_vue_client, Islands.Vue.ClientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "T6recmO7SNbZ2bcSt+qqAQks5VZy26NsI8KfPVgdKDdc26gUofcThivH4DOEclZf",
  render_errors: [
    view: Islands.Vue.ClientWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: Islands.Vue.Client.PubSub,
  live_view: [signing_salt: "Jprsk444"],
  # Allows Windows command => set port=4040 && mix phx.server
  http: [
    port:
      (System.get_env("PORT") || "4000")
      |> String.trim()
      |> String.to_integer()
  ]

# Signing salt to sign messages between the server and the client...
config :islands_vue_client, salt: "state auth"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "config_logger.exs"
import_config "#{Mix.env()}.exs"
