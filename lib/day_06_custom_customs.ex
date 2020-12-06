defmodule Adventofcode.Day06CustomCustoms do
  use Adventofcode

  def part_1(input) do
    input
    |> parse()
    |> Enum.map(&do_part_1/1)
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> parse()
    |> Enum.map(&do_part_2/1)
    |> Enum.sum()
  end

  defp do_part_1(group) do
    group
    |> Enum.flat_map(& &1)
    |> MapSet.new()
    |> MapSet.size()
  end

  defp do_part_2(group) do
    group
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.size()
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&parse_group/1)
  end

  defp parse_group(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_answer/1)
  end

  defp parse_answer(input) do
    input
    |> String.graphemes()
  end
end
