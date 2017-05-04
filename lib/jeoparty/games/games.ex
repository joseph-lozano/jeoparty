defmodule Jeoparty.Games do
  @moduledoc """
  The boundary for the Games system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Jeoparty.Repo

  alias Jeoparty.Games.Clue
  alias Jeoparty.Games.Game

  def get_clues(game_id) do
    key = "clues_#{game_id}"
    ConCache.get_or_store(:jeoparty_cache, key, fn() ->
      query = from c in Clue,
        where: c.game_id == ^game_id

      Repo.all(query)
      |> Enum.group_by(fn(el) -> el.round end)
      |> Enum.reduce(%{single: %{}, double: %{}, final: %{}, tiebreaker: %{}}, fn({round, clues}, acc) ->
        case round do
          1 ->
            put_in(acc, [:single], Enum.group_by(clues, fn(x) -> x.category end))
          2 ->
            put_in(acc, [:double], Enum.group_by(clues, fn(x) -> x.category end))
          3 ->
            put_in(acc, [:final], Enum.group_by(clues, fn(x) -> x.category end))
          4 ->
            put_in(acc, [:tiebreaker], Enum.group_by(clues, fn(x) -> x.category end))
        end
      end)
    end)
  end

  @doc """
  Gets a single clue.

  Raises `Ecto.NoResultsError` if the Clue does not exist.

  ## Examples

      iex> get_clue!(123)
      %Clue{}

      iex> get_clue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clue!(id), do: Repo.get!(Clue, id)

  @doc """
  Creates a clue.

  ## Examples

      iex> create_clue(%{field: value})
      {:ok, %Clue{}}

      iex> create_clue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clue(attrs \\ %{}) do
    %Clue{}
    |> clue_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clue.

  ## Examples

      iex> update_clue(clue, %{field: new_value})
      {:ok, %Clue{}}

      iex> update_clue(clue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clue(%Clue{} = clue, attrs) do
    clue
    |> clue_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Clue.

  ## Examples

      iex> delete_clue(clue)
      {:ok, %Clue{}}

      iex> delete_clue(clue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clue(%Clue{} = clue) do
    Repo.delete(clue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clue changes.

  ## Examples

      iex> change_clue(clue)
      %Ecto.Changeset{source: %Clue{}}

  """
  def change_clue(%Clue{} = clue) do
    clue_changeset(clue, %{})
  end

  defp clue_changeset(%Clue{} = clue, attrs) do
    clue
    |> cast(attrs, [:round, :category, :value, :clue, :correct_response, :game_id])
    |> validate_required([:round, :category, :value, :clue, :correct_response])
  end

  alias Jeoparty.Games.Game

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    ConCache.get_or_store(:jeoparty_cache, "all_games", fn() -> 
      IO.puts "INSIDE CACHE"
      Repo.all(Game)
    end)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id) do
    ConCache.get_or_store(:jeoparty_cache, "game_#{id}", fn() ->
      Repo.get!(Game, id)
    end)
  end

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    game = Repo.get_by(Game, show_number: attrs.show_number) 
    case game do
      nil ->
        %Game{} |> game_changeset(attrs) |> Repo.insert()
      _ ->
        {:ok, game}
    end
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> game_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{source: %Game{}}

  """
  def change_game(%Game{} = game) do
    game_changeset(game, %{})
  end

  defp game_changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:air_date, :show_number])
    |> validate_required([:air_date, :show_number])
  end
end
