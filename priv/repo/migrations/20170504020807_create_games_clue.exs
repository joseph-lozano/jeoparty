defmodule Jeoparty.Repo.Migrations.CreateJeoparty.Games.Clue do
  use Ecto.Migration

  def change do
    create table(:games_clues) do
      add :show_number, :integer
      add :air_date, :date
      add :round, :integer
      add :category, :text
      add :value, :integer
      add :question, :text
      add :answer, :text

      timestamps()
    end

  end
end
