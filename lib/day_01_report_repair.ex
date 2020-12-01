defmodule Adventofcode.Day01ReportRepair do
  use Adventofcode

  def part_1(input) do
    input
    |> parse()
    |> find_pair
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  defp find_pair(list) do
    for(x <- list, y <- list, x + y == 2020, do: x * y)
    |> hd()
  end
end
