defmodule Adventofcode.Day04PassportProcessing do
  use Adventofcode

  alias __MODULE__.{Parser, Passport}

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
      struct(__MODULE__, fields)
      |> check_valid
    end

    defp check_valid(%Passport{} = passport) do
      %{passport | valid?: valid?(passport)}
    end

    defp valid?(passport) do
      @enforce_keys
      |> List.delete(:cid)
      |> Enum.all?(&valid?(passport, &1))
    end

    defp valid?(passport, key), do: Map.get(passport, key) != nil
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
