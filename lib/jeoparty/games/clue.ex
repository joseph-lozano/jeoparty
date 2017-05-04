defmodule Jeoparty.Games.Clue do
  use Ecto.Schema

  schema "games_clues" do
    field :answer, :string
    field :category, :string
    field :question, :string
    field :round, :integer
    field :value, :integer
    field :game_id, :id

    timestamps()
  end
end
