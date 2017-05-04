defmodule Jeoparty.Web.GameController do
  alias Jeoparty.Games
  use Jeoparty.Web, :controller

  def index(conn, _params) do
    games = Games.list_games()
    assign(conn, :games, games)
    |> render("index.html")
  end

  def show(conn, %{"game_id" => game_id}) do
    game = Games.get_game!(game_id)
    clues = Games.get_clues(game_id)
    assign(conn, :clues, clues)
    |> render("show.html")
  end
end
