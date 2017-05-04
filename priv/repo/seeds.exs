alias Jeoparty.Games
NimbleCSV.define(Parser, separator: ",", escape: "\"")

File.stream!("./assets/jeopardy_clues.csv")
|> Parser.parse_stream
|> Stream.each(fn([show_number, air_date, round, category, value, question, answer]) ->
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

  attrs = %{}
  |> Map.put(:show_number, show_number)
  |> Map.put(:air_date,    air_date)
  |> Map.put(:round,       round)
  |> Map.put(:category,    category)
  |> Map.put(:value,       value)
  |> Map.put(:question,    question)
  |> Map.put(:answer,      answer)

  {:ok, game} =  Games.create_clue(attrs)
  IO.puts Map.get(game, :id)
end)
|> Stream.run
