defmodule Step do
  def apply(key, steps) do
    if Enum.empty?(steps) do
      key
    else
      ranges = List.first(steps) |> String.split("\n", trim: true)

      matching_range = Enum.find(ranges, fn range ->
        [_, start, length] = String.split(range, " ") |> Enum.map(&String.to_integer/1)
        Enum.member?(start..(start + length), key)
      end)

      destination = if matching_range do
        [destination, start, _] = String.split(matching_range, " ") |> Enum.map(&String.to_integer/1)
        key - start + destination
      else
        key
      end

      {_, next_steps} = List.pop_at(steps, 0)
      Step.apply(destination, next_steps)
    end
  end
end

{:ok, data} = File.read("input.txt")

regex = ~r/(?!\s|\w+:)([\d\s]+)/
[seeds | steps] = Regex.scan(regex, data, capture: :first) |> List.flatten()

seeds
|> String.replace("\n", "")
|> String.split(" ", trim: true)
|> Enum.map(fn seed -> Step.apply(String.to_integer(seed), steps) end)
|> Enum.min
|> IO.puts

# Part two notes
# Sort the location destinations, and brute force reversing the algorithm.

# Use the last map in this way, so brute forcing all values (including missing)
# humidity-to-location map:
# 1         1
# 2         2
# 3         3
# 2 4 10 -> 4..13
# 14        14
# 15        15
# 5 16 10 -> 16..25

# If last step (Enum.empty?(steps)) we just need to check all ranges and see if the current number is in
# any range of seeds

# Define another function to perform the last step. Doing something like:
# Enum.member?(start..(start + length), key) but start and lenght will be taken diffrently from the seeds
