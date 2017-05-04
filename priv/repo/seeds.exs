alias Jeoparty.Games
NimbleCSV.define(Parser, separator: ",", escape: "\"")

File.stream!("./assets/jeopardy_clues.csv")
|> Parser.parse_stream
|> Stream.each(fn([show_number, air_date, round, category, value, clue, correct_response]) ->
  show_number  = show_number |> String.to_integer

  dates = air_date
          |> String.split("-")
          |> Enum.map(fn(s) -> String.to_integer(s) end)
  {:ok, air_date} = Date.new(Enum.at(dates, 0), Enum.at(dates, 1), Enum.at(dates, 2))



  round = case round do 
    "Jeopardy!" -> 1
    "Double Jeopardy!" -> 2
    "Final Jeopardy!" -> 3
    "Tiebreaker" -> 4
  end

  value = case value do
          "None" -> 0
          _ ->
            value
            |> String.slice(1..-1)
            |> String.replace(",", "")
            |> String.to_integer
  end

  {:ok, game} = Games.create_game(%{show_number: show_number, air_date: air_date})

  attrs = %{}
  |> Map.put(:round,            round)
  |> Map.put(:category,         category)
  |> Map.put(:value,            value)
  |> Map.put(:clue,             clue)
  |> Map.put(:correct_response, correct_response)
  |> Map.put(:game_id,          game.id)

  {:ok, _clue} =  Games.create_clue(attrs)
end)
|> Stream.run
