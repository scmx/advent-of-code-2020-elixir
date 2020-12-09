defmodule Adventofcode.Day09EncodingError do
  use Adventofcode

  alias __MODULE__.{Part1, Part2, Parser}

  def part_1(input, preamble_size \\ 25) do
    input
    |> Parser.parse()
    |> Part1.run(preamble_size)
    |> elem(0)
  end

  def part_2(input, preamble_size \\ 25) do
    input
    |> Parser.parse()
    |> Part1.run(preamble_size)
    |> Part2.run()
  end

  defmodule Part1 do
    def run(numbers, preamble_size) do
      numbers
      |> Enum.chunk_every(preamble_size + 1, 1, :discard)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.filter(&matches_preamble?/1)
      |> Enum.map(fn [invalid_number | _] -> {invalid_number, numbers} end)
      |> hd()
    end

    defp matches_preamble?([num | preamble]) do
      num not in MapSet.new(for(a <- preamble, b <- preamble, a != b, do: a + b))
    end
  end

  defmodule Part2 do
    def run({invalid_number, numbers}) do
      numbers
      |> find_ranges()
      |> Enum.filter(&(Enum.sum(&1) == invalid_number))
      |> Enum.map(&(Enum.min(&1) + Enum.max(&1)))
      |> hd()
    end

    defp find_ranges(numbers) do
      index_range = 0..(length(numbers) - 1)

      Enum.flat_map(index_range, fn index ->
        index_range
        |> Enum.map(&Enum.slice(numbers, index, &1))
        |> Enum.filter(&(length(&1) >= 2))
      end)
    end
  end

  defmodule Parser do
    def parse(input) do
      ~r/-?\d+/
      |> Regex.scan(input)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
    end
  end
end
