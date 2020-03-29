defmodule Islands.Vue.ClientWeb.Presence do
  @dialyzer {:nowarn_function, init: 1}
  use Phoenix.Presence,
    otp_app: :islands_vue_client,
    pubsub_server: Islands.Vue.Client.PubSub
end
