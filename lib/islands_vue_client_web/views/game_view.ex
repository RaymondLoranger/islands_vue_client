defmodule Islands.Vue.ClientWeb.GameView do
  use Islands.Vue.ClientWeb, :view

  import Phoenix.HTML, only: [raw: 1]

  def player(%{name: name, gender: gender} = _player) do
    ~s|#{name} <img src="#{img(gender)}">| |> raw()
  end

  ## Private functions

  defp img(:m = _gender), do: "/images/male-sign.png"
  defp img(:f = _gender), do: "/images/female-sign.png"
  defp img(_gender), do: "/images/question-mark.png"
end
