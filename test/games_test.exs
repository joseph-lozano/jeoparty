defmodule Jeoparty.GamesTest do
  use Jeoparty.DataCase

  alias Jeoparty.Games
  alias Jeoparty.Games.Clue

  @create_attrs %{air_date: ~D[2010-04-17], answer: "some answer", category: "some category", question: "some question", round: 42, show_number: 42, value: 42}
  @update_attrs %{air_date: ~D[2011-05-18], answer: "some updated answer", category: "some updated category", question: "some updated question", round: 43, show_number: 43, value: 43}
  @invalid_attrs %{air_date: nil, answer: nil, category: nil, question: nil, round: nil, show_number: nil, value: nil}

  def fixture(:clue, attrs \\ @create_attrs) do
    {:ok, clue} = Games.create_clue(attrs)
    clue
  end

  test "list_clues/1 returns all clues" do
    clue = fixture(:clue)
    assert Games.list_clues() == [clue]
  end

  test "get_clue! returns the clue with given id" do
    clue = fixture(:clue)
    assert Games.get_clue!(clue.id) == clue
  end

  test "create_clue/1 with valid data creates a clue" do
    assert {:ok, %Clue{} = clue} = Games.create_clue(@create_attrs)
    assert clue.air_date == ~D[2010-04-17]
    assert clue.answer == "some answer"
    assert clue.category == "some category"
    assert clue.question == "some question"
    assert clue.round == 42
    assert clue.show_number == 42
    assert clue.value == 42
  end

  test "create_clue/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Games.create_clue(@invalid_attrs)
  end

  test "update_clue/2 with valid data updates the clue" do
    clue = fixture(:clue)
    assert {:ok, clue} = Games.update_clue(clue, @update_attrs)
    assert %Clue{} = clue
    assert clue.air_date == ~D[2011-05-18]
    assert clue.answer == "some updated answer"
    assert clue.category == "some updated category"
    assert clue.question == "some updated question"
    assert clue.round == 43
    assert clue.show_number == 43
    assert clue.value == 43
  end

  test "update_clue/2 with invalid data returns error changeset" do
    clue = fixture(:clue)
    assert {:error, %Ecto.Changeset{}} = Games.update_clue(clue, @invalid_attrs)
    assert clue == Games.get_clue!(clue.id)
  end

  test "delete_clue/1 deletes the clue" do
    clue = fixture(:clue)
    assert {:ok, %Clue{}} = Games.delete_clue(clue)
    assert_raise Ecto.NoResultsError, fn -> Games.get_clue!(clue.id) end
  end

  test "change_clue/1 returns a clue changeset" do
    clue = fixture(:clue)
    assert %Ecto.Changeset{} = Games.change_clue(clue)
  end
end
