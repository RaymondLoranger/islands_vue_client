defmodule Islands.Vue.Client.Player do
  @moduledoc """
  Creates a `player` struct for the _Game of Islands_.
  """

  alias __MODULE__
  alias Islands.{Game, PlayerID}
  alias Islands.Player, as: Gamer

  @genders [:f, :m]
  @modes [:manual, :auto]
  @pause_range 0..10_000
  @player_ids [:player1, :player2]

  @enforce_keys [:player_name, :gender]
  defstruct game_name: nil,
            player_name: nil,
            gender: nil,
            player_id: nil,
            mode: :manual,
            pause: 0

  @type t :: %Player{
          game_name: Game.name() | nil,
          player_name: Gamer.name(),
          gender: Gamer.gender(),
          player_id: PlayerID.t() | nil,
          mode: :manual | :auto,
          pause: 0..10_000
        }

  @spec new(Gamer.name(), Gamer.gender()) :: t
  def new(player_name, gender)
      when is_binary(player_name) and gender in @genders do
    %Player{player_name: player_name, gender: gender}
  end

  @spec update(t, Game.name(), PlayerID.t()) :: t
  def update(%Player{} = player, game_name, player_id)
      when is_binary(game_name) and player_id in @player_ids do
    %Player{player | game_name: game_name, player_id: player_id}
  end

  @spec switch_mode(t, :manual | :auto, 0..10_000) :: t
  def switch_mode(%Player{} = player, mode, pause)
      when mode in @modes and pause in @pause_range do
    %Player{player | mode: mode, pause: pause}
  end
end
