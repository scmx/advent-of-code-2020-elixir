defmodule Adventofcode.Day10AdapterArray do
  use Adventofcode

  def part_1(input) do
    input
    |> parse()
    |> add_min_max
    |> Enum.sort()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.reduce(&Kernel.*/2)
  end

  # def part_2(input) do
  #   input
  # end

  defp add_min_max(numbers) do
    [0, Enum.max(numbers) + 3 | numbers]
  end

  defp parse(input) do
    ~r/-?\d+/
    |> Regex.scan(input)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end
end
