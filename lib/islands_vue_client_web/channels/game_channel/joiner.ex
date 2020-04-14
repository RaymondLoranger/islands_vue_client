defmodule Islands.Vue.ClientWeb.GameChannel.Joiner do
  alias Islands.Client.State
  alias Islands.{Engine, Tally}
  alias Phoenix.Socket

  @spec join(Socket.t()) :: {:ok, Socket.t()} | {:error, map}
  def join(
        %Socket{
          assigns: %{
            player_state: %State{
              game_name: game_name,
              player_name: player_name,
              gender: gender,
              player_id: :player1
            }
          }
        } = socket
      ) do
    case Engine.new_game(game_name, player_name, gender, self()) do
      {:ok, pid} when is_pid(pid) ->
        self() |> send(:after_join)
        {:ok, socket}

      _error ->
        {:error, reason(:cannot_start, game_name)}
    end
  end

  def join(
        %Socket{
          assigns: %{
            player_state: %State{
              game_name: game_name,
              player_name: player_name,
              gender: gender,
              player_id: :player2
            }
          }
        } = socket
      ) do
    case Engine.add_player(game_name, player_name, gender, self()) do
      %Tally{response: {:ok, :player2_added}} ->
        self() |> send(:after_join)
        {:ok, socket}

      %Tally{response: {:error, :player2_already_added}} ->
        {:error, reason(:cannot_join, game_name)}

      _error ->
        {:error, reason(:game_not_found, game_name)}
    end
  end

  # Private functions

  @spec reason(atom, String.t()) :: map
  defp reason(:cannot_start, game_name) do
    %{
      reason: """
      Cannot start game <span style="color:DeepPink;">#{game_name}</span>.
      """
    }
  end

  defp reason(:cannot_join, game_name) do
    %{
      reason: """
      Cannot join game <span style="color:DeepPink;">#{game_name}</span>.
      """
    }
  end

  defp reason(:game_not_found, game_name) do
    %{
      reason: """
      Game <span style="color:DeepPink;">#{game_name}</span> not found!
      """
    }
  end
end
