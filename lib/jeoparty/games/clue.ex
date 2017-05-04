defmodule Jeoparty.Games.Clue do
  use Ecto.Schema

  schema "games_clues" do
    field :air_date, :date
    field :answer, :string
    field :category, :string
    field :question, :string
    field :round, :integer
    field :show_number, :integer
    field :value, :integer

    timestamps()
  end
end
