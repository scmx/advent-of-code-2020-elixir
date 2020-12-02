defmodule Adventofcode.Day02PasswordPhilosophy do
  use Adventofcode

  alias __MODULE__.{Part1, Part2}

  def part_1(input) do
    input
    |> parse()
    |> Part1.run()
  end

  def part_2(input) do
    input
    |> parse()
    |> Part2.run()
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    Regex.run(~r/^(\d+)-(\d+) ([a-z]): ([a-z]+)$/, line)
  end

  defmodule Part2 do
    def run(lines) do
      lines
      |> Enum.count(&check_positions/1)
    end

    defp check_positions([_, index1, index2, char, password]) do
      [index1, index2]
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(&String.at(password, &1 - 1))
      |> Enum.filter(&(&1 == char))
      |> length == 1
    end
  end

  defmodule Part1 do
    def run(lines) do
      lines
      |> Enum.map(&check_occurance/1)
      |> Enum.filter(&valid_password?/1)
      |> Enum.count()
    end

    defp check_occurance(nil), do: nil

    defp check_occurance([line, min, max, char, password]) do
      [line, min, max, char, do_check_occurance(password, char)]
    end

    defp do_check_occurance(password, char) do
      password
      |> String.graphemes()
      |> Enum.filter(&(&1 == char))
      |> Enum.join()
    end

    defp valid_password?(nil), do: false

    defp valid_password?([_, min, max, char, pass]) do
      min = String.to_integer(min)
      max = String.to_integer(max)
      String.length(pass) >= min && String.length(pass) <= max
    end
  end
end
