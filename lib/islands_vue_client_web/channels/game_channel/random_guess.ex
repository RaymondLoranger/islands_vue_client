defmodule Islands.Vue.ClientWeb.GameChannel.RandomGuess do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.Client.RandomGuess
  alias Islands.{Coord, Engine, Tally}
  alias Islands.Vue.Client.Player
  alias Islands.Vue.ClientWeb.GameChannel.GuessCoord
  alias Phoenix.Socket

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        payload,
        %Socket{
          assigns: %{
            player: %Player{
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

        if mode == :auto do
          {:ok, %Coord{row: row, col: col}} = Coord.new(square)
          push(:auto_mode_guess, socket, {pause, row, col})
          Process.sleep(pause)
        end

        GuessCoord.handle_in(%{"square" => square}, socket)

      _error ->
        broadcast!(:game_not_found, socket, {game_name})
        {:noreply, socket}
    end
  end
end
