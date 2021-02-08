defmodule Islands.Vue.ClientWeb.GameChannel.GameEnder do
  alias Islands.Engine

  require Logger

  @spec end_game(String.t()) :: :ok
  def end_game(game_name) do
    Logger.warn("Ending game '#{game_name}'...")
    Engine.end_game(game_name)
    :ok
  end
end
