number_dictionary = [
  ["one1one", ~r/one/],
  ["two2two", ~r/two/],
  ["three3three", ~r/three/],
  ["four4four", ~r/four/],
  ["five5five", ~r/five/],
  ["six6six", ~r/six/],
  ["seven7seven", ~r/seven/],
  ["eight8eight", ~r/eight/],
  ["nine9nine", ~r/nine/]
]

file = File.read!('input.txt')

Enum.reduce(number_dictionary, file, fn [number, regex], acc -> Regex.replace(regex, acc||file, number) end)
|> String.split("\n", trim: true)
|> Enum.map(fn x -> Regex.scan(~r/\d/, x) end)
|> Enum.map(fn y -> "#{List.first(y)}#{List.last(y)}" |> String.to_integer() end)
|> Enum.sum
|> IO.puts
