import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :islands_vue_client, Islands.Vue.ClientWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# config :file_only_logger, log?: true
# config :log_reset, levels: :all
