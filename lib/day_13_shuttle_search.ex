defmodule Adventofcode.Day13ShuttleSearch do
  use Adventofcode

  alias __MODULE__.{Part1}

  def part_1(input), do: input |> Part1.run()

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
end
