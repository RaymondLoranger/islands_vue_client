defmodule Islands.Vue.ClientWeb.GameChannel do
  use Islands.Vue.ClientWeb, :channel

  alias Islands.Engine

  def join("games:" <> game_name, _params, socket) do
    case Engine.game_pid(game_name) do
      pid when is_pid(pid) ->
        self() |> send({:after_join, game_name})
        {:ok, socket}

      nil ->
        {:error, %{reason: "Game does not exist"}}
    end
  end

  def handle_info({:after_join, game_name}, socket) do
    tally = Engine.tally(game_name, state(socket).player_id)
    :ok = push(socket, "game_tally", tally)
    {:noreply, socket}
  end

  ## Private functions

  defp state(socket) do
    socket.assigns.state
  end
end
