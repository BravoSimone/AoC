defmodule Cube do
  def compare([quantity, colour]) do
    available_cubes = %{ "red" => 12, "green" => 13, "blue" => 14 }

    available_cubes[colour] >= String.to_integer(quantity)
  end
end

File.read!('input.txt')
|> String.replace(~r/Game \d+: /, "")
|> String.split("\n", trim: true)
|> Enum.map(fn x -> String.split(x, "; ") end)
|> Enum.map(fn x -> Enum.map(x, fn y -> String.split(y, ", ") end) |> List.flatten  end)
|> Enum.map(fn cubes -> cubes |> Enum.map(fn cube -> Cube.compare(String.split(cube, " ")) end) end)
|> Enum.with_index
|> Enum.reduce(0, fn {draw, index}, acc -> if Enum.all?(draw) do acc + index + 1 else acc end end)
|> IO.puts
