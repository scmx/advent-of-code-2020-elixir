defmodule Adventofcode.Day14DockingData do
  use Adventofcode

  alias __MODULE__.{Part1, Part2}

  def part_1(input) do
    input
    |> parse
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> parse
    |> Part2.solve()
  end

  defmodule Part1 do
    defstruct mask: String.duplicate("x", 36), mem: %{}

    def solve(instructions) when is_list(instructions) do
      instructions
      |> Enum.reduce(%__MODULE__{}, &solve/2)
      |> sum
    end

    def solve({:mask, mask}, state) do
      %{state | mask: mask}
    end

    def solve({:mem, [address, value]}, %__MODULE__{mask: mask, mem: mem} = state) do
      value = value |> apply_mask(mask) |> String.to_integer(2)
      %{state | mem: Map.put(mem, address, value)}
    end

    def sum(%__MODULE__{mem: mem}) do
      mem
      |> Map.values()
      |> Enum.sum()
    end

    def apply_mask(num, mask) do
      [to_bitmask(num), mask]
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip()
      |> Enum.map(fn
        {current, "X"} -> current
        {_, new} -> new
      end)
      |> Enum.join("")
    end

    defp to_bitmask(val), do: val |> Integer.to_string(2) |> String.pad_leading(36, "0")
  end

  defmodule Part2 do
    defstruct mask: String.duplicate("x", 36), mem: %{}

    def solve(instructions) when is_list(instructions) do
      instructions
      |> Enum.reduce(%__MODULE__{}, &solve/2)
      |> sum
    end

    def solve({:mask, mask}, state) do
      %{state | mask: mask}
    end

    def solve({:mem, [address, value]}, %__MODULE__{mask: mask} = state) do
      address
      |> apply_mask(mask)
      |> Enum.map(&String.to_integer(&1, 2))
      |> Enum.reduce(state, &%{&2 | mem: Map.put(&2.mem, &1, value)})
    end

    def sum(%__MODULE__{mem: mem}) do
      mem
      |> Map.values()
      |> Enum.sum()
    end

    def apply_mask(num, mask) do
      [to_bitmask(num), mask]
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip()
      |> Enum.map(fn
        {current, "0"} -> current
        {_, new} -> new
      end)
      |> apply_floating("")
      |> Enum.map(&String.reverse/1)
    end

    def apply_floating(mask) when is_binary(mask) do
      mask
      |> String.graphemes()
      |> apply_floating("")
      |> Enum.map(&String.reverse/1)
    end

    def apply_floating([], result), do: [result]

    def apply_floating(["X" | tail], result) do
      ["0" <> result, "1" <> result]
      |> Enum.flat_map(&apply_floating(tail, &1))
    end

    def apply_floating([b | tail], result) do
      [b <> result]
      |> Enum.flat_map(&apply_floating(tail, &1))
    end

    defp to_bitmask(val), do: val |> Integer.to_string(2) |> String.pad_leading(36, "0")
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
  end

  defp parse_line("mask = " <> mask), do: {:mask, mask}

  defp parse_line("mem[" <> mem) do
    {:mem,
     ~r/\d+/
     |> Regex.scan(mem)
     |> List.flatten()
     |> Enum.map(&String.to_integer/1)}
  end
end
