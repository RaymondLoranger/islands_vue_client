defmodule Islands.Vue.ClientWeb.GameChannel.StopGame do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.{Engine, Tally}
  alias Islands.Vue.Client.Player
  alias Phoenix.Socket

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        payload,
        %Socket{
          assigns: %{
            player: %Player{
              game_name: game_name,
              player_name: player_name,
              player_id: player_id
            }
          }
        } = socket
      )
      when payload == %{} do
    case Engine.stop_game(game_name, player_id) do
      %Tally{} = tally ->
        push(:game_state, socket, {tally.game_state})

        case tally.response do
          {:ok, :stopping} ->
            push(:new_game, socket, {player_name})
            push(:you_stopped, socket, {player_name})

          {:error, :player2_not_added} ->
            push(:player2_not_added, socket, {player_name})

          {:error, :not_both_players_islands_set} ->
            push(:not_both_players_islands_set, socket, {})

          {:error, :not_player_turn} ->
            push(:not_your_turn, socket, {})

          {:error, :game_over} ->
            broadcast!(:game_over, socket, {game_name})

          {:error, reason} ->
            push(:error, socket, {reason})
        end

      _error ->
        broadcast!(:game_not_found, socket, {game_name})
    end

    {:noreply, socket}
  end
end
