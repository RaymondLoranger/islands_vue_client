defmodule Islands.Vue.Client.Player do
  @moduledoc """
  Creates a `player` struct for the _Game of Islands_.
  """

  alias __MODULE__
  alias Islands.{Game, PlayerID}
  alias Islands.Player, as: Gamer

  @enforce_keys [:player_name, :gender]
  defstruct [:game_name, :player_name, :gender, :player_id]

  @type t :: %Player{
          game_name: Game.name() | nil,
          player_name: Gamer.name(),
          gender: Gamer.gender(),
          player_id: PlayerID.t() | nil
        }

  @spec new(Gamer.name(), Gamer.gender()) :: t
  def new(player_name, gender) do
    %Player{player_name: player_name, gender: gender}
  end
end
