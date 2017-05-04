defmodule Jeoparty.Repo.Migrations.CreateJeoparty.Games.Game do
  use Ecto.Migration

  def change do
    create table(:games_games) do
      add :air_date, :date
      add :show_number, :integer

      timestamps()
    end
    create unique_index(:games_games, [:show_number])
  end
end
