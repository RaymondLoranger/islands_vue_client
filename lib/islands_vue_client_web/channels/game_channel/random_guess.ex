defmodule Islands.Vue.ClientWeb.GameChannel.RandomGuess do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.Client.{RandomGuess, State}
  alias Islands.{Engine, Tally}
  alias Islands.Vue.ClientWeb.GameChannel.GuessCoord
  alias Phoenix.Socket

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        payload,
        %Socket{
          assigns: %{
            player_state: %State{
              game_name: game_name,
              player_id: player_id,
              mode: mode,
              pause: pause
            }
          }
        } = socket
      )
      when payload == %{} do
    case Engine.tally(game_name, player_id) do
      %Tally{} = tally ->
        square = RandomGuess.new(tally)
        if mode == :auto, do: Process.sleep(pause)
        GuessCoord.handle_in(%{"square" => square}, socket)

      _error ->
        broadcast!(:game_not_found, socket, {game_name})
        {:noreply, socket}
    end
  end
end
