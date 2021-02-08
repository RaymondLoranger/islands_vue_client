defmodule Islands.Vue.ClientWeb.GameChannel.Terminator do
  alias Islands.Client.State
  alias Islands.Vue.ClientWeb.GameChannel.GameEnder
  alias Phoenix.Socket

  require Logger

  @spec terminate(term, Socket.t()) :: :ok
  def terminate(
        reason,
        %Socket{
          assigns: %{
            player_state: %State{
              game_name: game_name,
              player_name: player_name,
              player_id: player_id
            }
          }
        }
      ) do
    Logger.warn("#{player_name} (#{player_id}) has left game '#{game_name}'.")
    Logger.warn("Reason: #{inspect(reason)}")
    GameEnder.end_game(game_name)
  end
end
