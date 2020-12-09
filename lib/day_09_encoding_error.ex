defmodule Adventofcode.Day09EncodingError do
  use Adventofcode

  alias __MODULE__.{Part1, Parser}

  def part_1(input, preamble_size \\ 25) do
    input
    |> Parser.parse()
    |> Part1.run(preamble_size)
    |> elem(0)
  end

  # def part_2(input) do
  #   input
  # end

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

  defmodule Parser do
    def parse(input) do
      ~r/-?\d+/
      |> Regex.scan(input)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
    end
  end
end
