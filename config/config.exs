# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Mix messages in colors...
config :elixir, ansi_enabled: true

# General application configuration
config :islands_vue_client,
  namespace: Islands.Vue.Client

# Configures the endpoint
config :islands_vue_client, Islands.Vue.ClientWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "tUZpy5+V8tzRtOefiHqlBZ3qlgmoXR4uiEd9z7M7wYqBqpAUb960pHxpgXAwlFcj",
  render_errors: [view: Islands.Vue.ClientWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Islands.Vue.Client.PubSub, adapter: Phoenix.PubSub.PG2]

config :islands_vue_client, salt: "player auth"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "config_*.exs"
import_config "#{Mix.env()}.exs"
