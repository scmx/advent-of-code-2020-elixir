defmodule Adventofcode.Day14DockingData do
  use Adventofcode

  alias __MODULE__.State

  def part_1(input) do
    input
    |> parse
    |> solve(State.new())
    |> State.sum()
  end

  # def part_2(input) do
  #   input
  # end

  defmodule State do
    defstruct mask: String.duplicate("x", 36), mem: %{}

    def new, do: %__MODULE__{}

    def put(%State{mask: mask, mem: mem} = state, address, value) do
      %{state | mem: Map.put(mem, address, apply_mask_to_value(value, mask))}
    end

    def sum(%State{mem: mem}), do: mem |> Map.values() |> Enum.sum()

    defp apply_mask_to_value(val, mask) do
      [to_bitmask(val), mask]
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip()
      |> Enum.map(fn
        {current, "X"} -> current
        {_, new} -> new
      end)
      |> Enum.join("")
      |> String.to_integer(2)
    end

    defp to_bitmask(val), do: val |> Integer.to_string(2) |> String.pad_leading(36, "0")
  end

  def solve(instructions, state) when is_list(instructions) do
    Enum.reduce(instructions, state, &solve/2)
  end

  def solve({:mask, mask}, state) do
    %{state | mask: mask}
  end

  def solve({:mem, [address, value]}, state) do
    State.put(state, address, value)
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
