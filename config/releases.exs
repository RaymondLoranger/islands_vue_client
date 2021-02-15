import Config

case config_env() do
  :prod ->
    config :islands_vue_client, Islands.Vue.ClientWeb.Endpoint,
      server: true,
      # Needed for Phoenix 1.2 and 1.4. Doesn't hurt for 1.3.
      http: [port: {:system, "PORT"}],
      # http: [port: System.get_env("PORT") || "4040"],
      # url: [host: "localhost"]
      url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 443]

  _else ->
    config :islands_vue_client, Islands.Vue.ClientWeb.Endpoint, server: true
end
