defmodule Adventofcode.Day15RambunctiousRecitation do
  use Adventofcode

  alias __MODULE__.Memory

  def part_1(input) do
    input
    |> parse
    |> Memory.new()
    |> Memory.play()
    |> Memory.by_turn(2020)
  end

  # def part_2(input) do
  #   input
  # end
  #
  defmodule Memory do
    defstruct turn: 0, turns: %{}, spoken: %{}

    def new(starting_numbers) do
      turn = length(starting_numbers)
      turns = Map.new(starting_numbers, fn {val, turn} -> {turn, val} end)
      spoken = Map.new(starting_numbers, fn {val, turn} -> {val, [turn]} end)

      %__MODULE__{turn: turn, turns: turns, spoken: spoken}
    end

    def play(%Memory{turn: 2020} = memory), do: memory

    def play(%Memory{} = memory), do: memory |> step() |> play()

    def step(%Memory{} = memory) do
      last = by_turn(memory, memory.turn)

      case by_spoken(memory, last) do
        [_num] -> speak(memory, 0)
        [num, num2 | _] -> speak(memory, num - num2)
      end
    end

    def by_turn(%Memory{turns: turns}, turn), do: Map.get(turns, turn)

    def by_spoken(%Memory{spoken: spoken}, num), do: Map.get(spoken, num)

    defp speak(%Memory{turns: turns, spoken: spoken} = memory, num) do
      turn = memory.turn + 1
      turns = Map.put(turns, turn, num)
      spoken = Map.update(spoken, num, [turn], &[turn | &1])
      %{memory | turn: turn, turns: turns, spoken: spoken}
    end
  end

  def parse(input) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.map(fn {val, index} -> {val, index + 1} end)
  end
end
