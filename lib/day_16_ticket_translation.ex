defmodule Adventofcode.Day16TicketTranslation do
  use Adventofcode

  alias __MODULE__.{Parser, Part1}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  # def part_2(input) do
  #   input
  # end

  defmodule Part1 do
    def solve([rules, _your_ticket, nearby_tickets]) do
      all_ranges = rules |> Enum.flat_map(&tl/1)

      nearby_tickets
      |> List.flatten()
      |> Enum.reject(fn num -> Enum.any?(all_ranges, &(num in &1)) end)
      |> Enum.sum()
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n\n")
      |> Enum.map(&parse_group/1)
    end

    defp parse_group("your ticket:" <> _ = group) do
      group
      |> String.split("\n")
      |> Enum.at(1)
      |> parse_ticket
    end

    defp parse_group("nearby tickets:" <> _ = group) do
      group
      |> String.split("\n")
      |> Enum.drop(1)
      |> Enum.map(&parse_ticket/1)
    end

    defp parse_group(group) do
      group
      |> String.split("\n")
      |> Enum.map(&Regex.split(~r/(: | or )/, &1))
      |> Enum.map(&[hd(&1) | parse_ranges(tl(&1))])
    end

    defp parse_ranges(ranges) do
      ranges
      |> Enum.map(&String.split(&1, "-"))
      |> Enum.map(&parse_range/1)
    end

    defp parse_range([a, b]), do: String.to_integer(a)..String.to_integer(b)

    defp parse_ticket(ticket) do
      ticket
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end
  end
end
