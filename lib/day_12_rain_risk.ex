defmodule Adventofcode.Day12RainRisk do
  use Adventofcode

  alias __MODULE__.{Captain, Position, State, Waypoint}

  def part_1(input) do
    input
    |> parse
    |> Captain.operate(State.part_1())
    |> manhattan_distance
  end

  # def part_2(input) do
  #   input
  # end

  defmodule Captain do
    def operate("E" <> val, state), do: State.move(state, {String.to_integer(val), 0})
    def operate("W" <> val, state), do: State.move(state, {-String.to_integer(val), 0})
    def operate("N" <> val, state), do: State.move(state, {0, String.to_integer(val)})
    def operate("S" <> val, state), do: State.move(state, {0, -String.to_integer(val)})
    def operate("R" <> val, state), do: State.rotate(state, String.to_integer(val))
    def operate("L" <> val, state), do: State.rotate(state, 360 - String.to_integer(val))
    def operate("F" <> val, state), do: State.forward(state, String.to_integer(val))

    def operate(instructions, state), do: Enum.reduce(instructions, state, &operate/2)
  end

  defmodule State do
    @enforce_keys [:waypoint, :logic]
    defstruct ship: {0, 0}, waypoint: nil, logic: nil

    def part_1(opts \\ []), do: struct(__MODULE__, [logic: :part_1, waypoint: {1, 0}] ++ opts)

    def move(%State{logic: :part_1} = state, {east, north}) do
      %{state | ship: Position.move(state.ship, {east, north})}
    end

    end

    def rotate(%State{} = state, degrees) do
      %{state | waypoint: Waypoint.rotate(state.waypoint, degrees)}
    end

    def forward(%State{} = state, 0), do: state

    def forward(%State{} = state, times) do
      %{state | ship: Position.move(state.ship, state.waypoint)}
      |> forward(times - 1)
    end
  end

  defmodule Position do
    def move({east, north}, {dx, dy}), do: {east + dx, north + dy}
  end

  defmodule Waypoint do
    def rotate({east, north}, 90), do: {east, north} |> transpose |> flip
    def rotate({east, north}, 180), do: {east, north} |> flip |> mirror
    def rotate({east, north}, 270), do: {east, north} |> transpose |> mirror

    defp transpose({east, north}), do: {north, east}
    defp mirror({east, north}), do: {east * -1, north}
    defp flip({east, north}), do: {east, north * -1}
  end

  def manhattan_distance(%State{ship: {east, north}}), do: abs(east) + abs(north)

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end
end
