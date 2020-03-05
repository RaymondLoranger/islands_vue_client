defmodule Islands.Vue.ClientWeb.GameController do
  use Islands.Vue.ClientWeb, :controller

  alias Islands.Vue.Client.HaikuName
  alias Islands.Client.State
  alias Islands.{Engine, Player}

  @salt Application.get_env(:islands_vue_client, :salt)

  plug :require_player

  def new(conn, _params) do
    game_name = HaikuName.generate()
    %Player{name: name, gender: gender, pid: pid} = get_session(conn, :player)

    case Engine.new_game(game_name, name, gender, pid) do
      {:ok, _game_pid} ->
        state = State.new(game_name, :player1, name, gender)

        conn
        |> put_session(:state, state)
        |> put_flash(:info, "#{name}, please invite an opponent to join.")
        |> put_flash(:error, "#{name}, please wait for an opponent to join.")
        |> show(game_name)

      {:error, _error} ->
        conn
        |> put_flash(:error, "Unable to start game!")
        |> redirect(to: session_path(conn, :new))
    end
  end

  def join(conn, %{"id" => game_name} = _params) do
    %Player{name: name, gender: gender, pid: pid} = get_session(conn, :player)
    Engine.add_player(game_name, name, gender, pid)
    state = State.new(game_name, :player2, name, gender)
    tally = Engine.position_all_islands(game_name, :player2)
    hits_and_misses(game_name, tally)

    conn
    |> put_session(:state, state)
    |> put_flash(:info, "#{name}, you've joined the game.")
    |> put_flash(:error, "#{name}, please wait for your opponent to play.")
    |> show(game_name)
  end

  ## Private functions

  defp hits_and_misses(game_name, tally) do
    Engine.position_all_islands(game_name, :player1)
    Engine.set_islands(game_name, :player1)
    Engine.set_islands(game_name, :player2)
    board = tally.board
    islands = board.islands
    atoll = islands.atoll
    atoll_coords = atoll.coords
    %{row: row, col: col} = atoll_coords |> MapSet.to_list() |> List.first()
    Engine.guess_coord(game_name, :player1, row, col)
    Engine.guess_coord(game_name, :player2, 10, 10)
    %{row: row, col: col} = atoll_coords |> MapSet.to_list() |> List.last()
    Engine.guess_coord(game_name, :player1, row, col)
    Engine.guess_coord(game_name, :player2, 9, 10)
    Engine.guess_coord(game_name, :player1, 1, 5)
    Engine.guess_coord(game_name, :player2, 8, 10)
    Engine.guess_coord(game_name, :player1, 1, 6)
  end

  defp show(conn, game_name) do
    case Engine.game_pid(game_name) do
      pid when is_pid(pid) ->
        conn
        |> assign(:game_name, game_name)
        |> assign(:auth_token, generate_auth_token(conn))
        |> render("show.html")

      nil ->
        conn
        |> put_flash(:error, "Game not found!")
        |> redirect(to: session_path(conn, :new))
    end
  end

  defp require_player(conn, _opts) do
    if get_session(conn, :player) do
      conn
    else
      conn
      |> put_session(:return_to, conn.request_path)
      |> redirect(to: session_path(conn, :new))
      |> halt()
    end
  end

  defp generate_auth_token(conn) do
    state = get_session(conn, :state)
    Phoenix.Token.sign(conn, @salt, state)
  end
end
