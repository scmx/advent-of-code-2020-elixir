defmodule Adventofcode.Day22CrabCombat do
  use Adventofcode

  alias __MODULE__.{Parser, Part1}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  defmodule Part1 do
    def solve([[], deck]),
      do: score(deck)

    def solve([deck, []]),
      do: score(deck)

    def solve([[card1 | deck1], [card2 | deck2]]) when card1 > card2,
      do: solve([deck1 ++ [card1, card2], deck2])

    def solve([[card1 | deck1], [card2 | deck2]]),
      do: solve([deck1, deck2 ++ [card2, card1]])

    defp score(deck) do
      deck
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn {n, i} -> n * (i + 1) end)
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

    defp parse_group(group) do
      group
      |> String.split("\n")
      |> Enum.drop(1)
      |> Enum.map(&String.to_integer/1)
    end
  end
end
