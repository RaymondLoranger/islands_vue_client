defmodule Islands.Vue.ClientWeb.GameView do
  use Islands.Vue.ClientWeb, :view

  import Phoenix.HTML, only: [raw: 1]

  def player1(%{player1_name: name, player1_gender: _gender} = _overview) do
    ~s|#{name} <img src="/images/male-sign.png">| |> raw()
  end

  def player2(%{player2_name: name, player2_gender: gender} = _overview) do
    "#{name}: #{gender} "
  end
end
