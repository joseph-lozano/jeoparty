defmodule Jeoparty.Games.Clue do
  use Ecto.Schema

  schema "games_clues" do
    field :correct_response, :string
    field :category, :string
    field :clue, :string
    field :round, :integer
    field :value, :integer
    field :game_id, :id

    timestamps()
  end
end
