defmodule Adventofcode.Day04PassportProcessing do
  use Adventofcode

  alias __MODULE__.{Passport, Parser}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Enum.count(& &1.valid?)
  end

  # def part_2(input) do
  #   input
  # end

  defmodule Passport do
    @enforce_keys [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid]
    defstruct [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid, :valid?]

    def new(fields) do
      passport = struct(__MODULE__, fields)
      %{passport | valid?: valid?(passport)}
    end

    defp valid?(passport) do
      @enforce_keys
      |> List.delete(:cid)
      |> Enum.all?(&(Map.get(passport, &1) != nil))
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.split("\n\n")
      |> Enum.map(&parse_passport/1)
    end

    def parse_passport(lines) do
      lines
      |> String.trim()
      |> String.split(~r/\s+/)
      |> Enum.map(&String.split(&1, ":"))
      |> Enum.map(fn [k, v] -> {String.to_atom(k), v} end)
      |> Passport.new()
    end
  end
end
