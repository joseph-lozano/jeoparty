defmodule Jeoparty.Games.Game do
  use Ecto.Schema

  schema "games_games" do
    field :air_date, :date
    field :show_number, :integer

    timestamps()
  end
end
