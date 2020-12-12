defmodule Adventofcode.Day12RainRisk do
  use Adventofcode

  alias __MODULE__.{Part1, Part2, State}

  def part_1(input) do
    input
    |> parse
    |> travel(Part1)
    |> manhattan_distance
  end

  # def part_2(input) do
  #   input
  # end

  defmodule State do
    defstruct east: 0, north: 0, direction: :east

    def new, do: %__MODULE__{}
  end

  defmodule Part1 do
    def move(:west, %State{} = state, val), do: move(:east, state, -val)

    def move(:east, %State{east: east} = state, val) do
      %{state | east: east + val}
    end

    def move(:south, %State{} = state, val), do: move(:north, state, -val)

    def move(:north, %State{north: north} = state, val) do
      %{state | north: north + val}
    end

    @directions [:east, :south, :west, :north]
    def right(%State{direction: direction} = state, val) do
      current = Enum.find_index(@directions, &(&1 == direction))
      direction = Enum.at(@directions, rem(current + div(val, 90), length(@directions)))
      %{state | direction: direction}
    end

    def forward(%State{} = state, val), do: move(state.direction, state, val)
  end

  defmodule Part2 do
  end

  def travel(instructions, module) do
    Enum.reduce(instructions, State.new(), fn
      {"N", val}, acc -> apply(module, :move, [:north, acc, val])
      {"S", val}, acc -> apply(module, :move, [:south, acc, val])
      {"E", val}, acc -> apply(module, :move, [:east, acc, val])
      {"W", val}, acc -> apply(module, :move, [:west, acc, val])
      {"R", val}, acc -> apply(module, :right, [acc, val])
      {"L", val}, acc -> apply(module, :right, [acc, -val])
      {"F", val}, acc -> apply(module, :forward, [acc, val])
    end)
  end

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&{String.at(&1, 0), String.to_integer(String.slice(&1, 1..-1))})
  end

  def manhattan_distance(%State{east: east, north: north}), do: abs(east) + abs(north)
end
