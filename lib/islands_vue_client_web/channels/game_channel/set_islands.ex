defmodule Islands.Vue.ClientWeb.GameChannel.SetIslands do
  import Islands.Vue.ClientWeb.GameChannel.Event

  alias Islands.Client.State
  alias Islands.{Engine, Tally}
  alias Phoenix.Socket

  @spec handle_in(map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in(
        payload,
        %Socket{
          assigns: %{
            player_state: %State{
              game_name: game_name,
              player_name: player_name,
              player_id: player_id
            }
          }
        } = socket
      )
      when payload == %{} do
    case Engine.set_islands(game_name, player_id) do
      %Tally{} = tally ->
        push(:game_state, socket, {tally.game_state})
        push(:player_state, socket, {player_id, tally})

        case tally.game_state do
          :initialized ->
            push(:player2_not_added, socket, {player_name})

          :players_set ->
            opponent_gender = tally.guesses_score.gender
            push(:you_set_islands, socket, {})
            push(:wait_for_set_islands, socket, {player_name, opponent_gender})

          :player1_turn ->
            case tally.response do
              {:ok, :islands_set} ->
                push(:you_set_islands, socket, {})

                case player_id do
                  :player1 -> push(:please_make_move, socket, {player_name})
                  :player2 -> push(:wait_for_make_move, socket, {player_name})
                end

              {:error, :both_players_islands_set} ->
                push(:both_players_islands_set, socket, {})

              {:error, reason} ->
                push(:error, socket, {reason})
            end

          :player2_turn ->
            push(:both_players_islands_set, socket, {})

          :game_over ->
            broadcast!(:game_over, socket, {game_name})
        end

      _error ->
        broadcast!(:game_not_found, socket, {game_name})
    end

    {:noreply, socket}
  end
end
