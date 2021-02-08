defmodule Islands.Vue.ClientWeb.GameChannel do
  use Islands.Vue.ClientWeb, :channel

  alias Islands.Vue.ClientWeb.GameChannel.{
    AfterJoin,
    ChatMessage,
    GameOver,
    GuessCoord,
    Joiner,
    OpponentLeft,
    PlayerTurn,
    PlayersSet,
    PositionIsland,
    RandomGuess,
    RandomPositions,
    SetIslands,
    StopGame,
    SwitchMode,
    Terminator,
    Unexpected
  }

  alias Phoenix.Socket

  @spec join(String.t(), map, Socket.t()) :: {:ok, Socket.t()} | {:error, map}
  def join(_topic, _payload, %Socket{} = socket), do: Joiner.join(socket)

  @spec handle_info(msg :: term, Socket.t()) :: {:noreply, Socket.t()}
  def handle_info(:after_join, %Socket{} = socket),
    do: AfterJoin.handle_info(socket)

  def handle_info(:players_set, %Socket{} = socket),
    do: PlayersSet.handle_info(socket)

  def handle_info(msg, %Socket{} = socket)
      when msg in [:player1_turn, :player2_turn],
      do: PlayerTurn.handle_info(socket)

  def handle_info(:game_over, %Socket{} = socket),
    do: GameOver.handle_info(socket)

  def handle_info(msg, %Socket{} = socket),
    do: Unexpected.handle_info(msg, socket)

  @spec handle_in(String.t(), map, Socket.t()) :: {:noreply, Socket.t()}
  def handle_in("random_positions", %{} = payload, %Socket{} = socket),
    do: RandomPositions.handle_in(payload, socket)

  def handle_in("set_islands", %{} = payload, %Socket{} = socket),
    do: SetIslands.handle_in(payload, socket)

  def handle_in("switch_mode", %{} = payload, %Socket{} = socket),
    do: SwitchMode.handle_in(payload, socket)

  def handle_in("position_island", %{} = payload, %Socket{} = socket),
    do: PositionIsland.handle_in(payload, socket)

  def handle_in("random_guess", %{} = payload, %Socket{} = socket),
    do: RandomGuess.handle_in(payload, socket)

  def handle_in("guess_coord", %{} = payload, %Socket{} = socket),
    do: GuessCoord.handle_in(payload, socket)

  def handle_in("stop_game", %{} = payload, %Socket{} = socket),
    do: StopGame.handle_in(payload, socket)

  def handle_in("opponent_left", %{} = payload, %Socket{} = socket),
    do: OpponentLeft.handle_in(payload, socket)

  def handle_in("chat_message", %{} = payload, %Socket{} = socket),
    do: ChatMessage.handle_in(payload, socket)

  def handle_in(event, %{} = payload, %Socket{} = socket),
    do: Unexpected.handle_in(event, payload, socket)

  @spec terminate(term, Socket.t()) :: :ok
  def terminate(reason, socket), do: Terminator.terminate(reason, socket)
end
