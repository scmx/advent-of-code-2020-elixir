defmodule Adventofcode.Day04PassportProcessing do
  use Adventofcode

  alias __MODULE__.{Parser, Passport, StrictPassport}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Enum.count(& &1.valid?)
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Enum.count(& &1.strictly_valid?)
  end

  defmodule Passport do
    @enforce_keys [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid]
    defstruct [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid, :valid?, :strictly_valid?]

    def new(fields) do
      struct(__MODULE__, fields)
      |> check_valid
      |> check_strictly_valid
    end

    defp check_valid(%Passport{} = passport) do
      %{passport | valid?: valid?(passport)}
    end

    defp check_strictly_valid(%Passport{valid?: false} = passport) do
      %{passport | strictly_valid?: false}
    end

    defp check_strictly_valid(%Passport{} = passport) do
      %{passport | strictly_valid?: strictly_valid?(passport)}
    end

    defp valid?(passport) do
      @enforce_keys
      |> List.delete(:cid)
      |> Enum.all?(&valid?(passport, &1))
    end

    defp valid?(passport, key), do: Map.get(passport, key) != nil

    def strictly_valid?(passport) do
      @enforce_keys
      |> List.delete(:cid)
      |> Enum.all?(&strictly_valid?(passport, &1))
    end

    def strictly_valid?(passport, key) do
      valid?(passport, key) && StrictPassport.valid?(passport, key)
    end
  end

  defmodule StrictPassport do
    alias Passport

    def valid?(%Passport{valid?: true, byr: byr}, :byr) do
      String.length(byr) == 4 && String.to_integer(byr) in 1920..2002
    end

    def valid?(%Passport{valid?: true, iyr: iyr}, :iyr) do
      String.length(iyr) == 4 && String.to_integer(iyr) in 2010..2020
    end

    def valid?(%Passport{valid?: true, eyr: eyr}, :eyr) do
      String.length(eyr) == 4 && String.to_integer(eyr) in 2020..2030
    end

    def valid?(%Passport{valid?: true, hgt: hgt}, :hgt) do
      case Integer.parse(hgt) do
        {val, "cm"} ->
          val in 150..193

        {val, "in"} ->
          val in 59..76

        _ ->
          false
      end
    end

    def valid?(%Passport{valid?: true, hcl: hcl}, :hcl) do
      Regex.match?(~r/^#[abcdef0-9]{6}$/, hcl)
    end

    def valid?(%Passport{valid?: true, ecl: ecl}, :ecl) do
      ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    end

    def valid?(%Passport{valid?: true, pid: pid}, :pid) do
      Regex.match?(~r/^\d{9}$/, pid)
    end

    def valid?(%Passport{}, :cid), do: true
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
