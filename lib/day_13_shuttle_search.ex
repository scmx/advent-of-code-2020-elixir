defmodule Adventofcode.Day13ShuttleSearch do
  use Adventofcode

  alias __MODULE__.{Part1, Part2}

  def part_1(input), do: input |> Part1.run()
  def part_2(input), do: input |> Part2.run()

  defmodule Part1 do
    def run(input) do
      input
      |> parse
      |> solve
    end

    defp solve([earliest | buses]) do
      buses
      |> Enum.map(&do_check_time(earliest, &1))
      |> Enum.sort_by(&elem(&1, 0))
      |> Enum.map(&elem(&1, 2))
      |> hd()
    end

    defp do_check_time(earliest, bus) do
      depart = earliest + bus - rem(earliest, bus)
      {depart, bus, (depart - earliest) * bus}
    end

    defp parse(input) do
      ~r/\d+/
      |> Regex.scan(input)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
    end
  end

  defmodule Part2 do
    def run(input) do
      input
      |> parse
      |> Enum.reduce(&solve/2)
      |> elem(1)
    end

    def solve({bus, offset}, {acc, index}) do
      remainder = rem(bus * offset - offset, bus)

      Enum.find_value(Stream.iterate(1, &(&1 + 1)), fn
        n when rem(n * acc + index, bus) != remainder -> nil
        n -> {acc * bus, n * acc + index}
      end)
    end

    defp parse(input) do
      input
      |> String.split("\n")
      |> Enum.at(1)
      |> String.split(",")
      |> Enum.with_index()
      |> Enum.reject(&(elem(&1, 0) == "x"))
      |> Enum.map(&{String.to_integer(elem(&1, 0)), elem(&1, 1)})
    end
  end
end
