defmodule Jeoparty.Games do
  @moduledoc """
  The boundary for the Games system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Jeoparty.Repo

  alias Jeoparty.Games.Clue

  @doc """
  Returns the list of clues.

  ## Examples

      iex> list_clues()
      [%Clue{}, ...]

  """
  def list_clues do
    Repo.all(Clue)
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
    |> cast(attrs, [:show_number, :air_date, :round, :category, :value, :question, :answer])
    |> validate_required([:show_number, :air_date, :round, :category, :value, :question, :answer])
  end
end
