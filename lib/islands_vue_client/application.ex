defmodule Islands.Vue.Client.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Islands.Vue.ClientWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Islands.Vue.Client.PubSub},
      # Start the Endpoint (http/https)
      Islands.Vue.ClientWeb.Endpoint
      # Start a worker by calling: Islands.Vue.Client.Worker.start_link(arg)
      # {Islands.Vue.Client.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Islands.Vue.Client.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Islands.Vue.ClientWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
