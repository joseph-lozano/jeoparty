defmodule Jeoparty.Repo.Migrations.CreateJeoparty.Games.Clue do
  use Ecto.Migration

  def change do
    create table(:games_clues) do
      add :round, :integer
      add :category, :text
      add :value, :integer
      add :clue, :text
      add :correct_response, :text
      add :game_id, references(:games_games, on_delete: :nothing)

      timestamps()
    end

    create index(:games_clues, [:game_id])
  end
end
