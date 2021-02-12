defmodule Islands.Vue.ClientWeb.GameView do
  use Islands.Vue.ClientWeb, :view

  import Phoenix.HTML, only: [raw: 1]

  def player(%{name: name, gender: _gender} = _overview_player) do
    ~s|#{name} <img src="/images/male-sign.png">| |> raw()
  end
end
