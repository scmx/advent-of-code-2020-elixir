defmodule Adventofcode.Day11SeatingSystem do
  use Adventofcode

  alias __MODULE__.{Printer, State}

  def part_1(input) do
    input
    |> parse()
    |> State.new(tolerant: false)
    |> step_until_stable
    |> State.count_occupied()
  end

  # def part_2(input) do
  #   input
  # end

  defmodule State do
    @enforce_keys [:grid, :x_range, :y_range]
    defstruct grid: %{}, x_range: 0..0, y_range: 0..0, step: 0

    def new(grid) do
      width = grid |> hd |> Enum.count()
      height = grid |> Enum.count()

      %__MODULE__{
        grid: grid |> List.flatten() |> Enum.into(%{}),
        x_range: 0..(width - 1),
        y_range: 0..(height - 1)
      }
    end

    def get(%State{grid: grid}, {x, y}), do: Map.get(grid, {x, y})

    def put(%State{grid: grid} = state, {x, y}, val) when val in '.L#' do
      %{state | grid: Map.put(grid, {x, y}, val)}
    end

    def count_occupied(%State{grid: grid}) do
      Enum.count(grid, &(elem(&1, 1) == ?#))
    end
  end

  def step_until_stable(%State{} = state) do
    next = state |> step
    if next.grid == state.grid, do: state, else: step_until_stable(next)
  end

  def step(%State{} = state) do
    Enum.reduce(state.grid, %{state | step: state.step + 1}, fn {{x, y}, char}, acc ->
      neighbours = get_neighbours({x, y}, state)

      cond do
        char == ?. -> acc
        char == ?L && neighbours == 0 -> State.put(acc, {x, y}, ?#)
        char == ?# && neighbours >= 4 -> State.put(acc, {x, y}, ?L)
        true -> acc
      end
    end)
  end

  @neighbours [
    {-1, -1},
    {0, -1},
    {1, -1},
    {-1, 0},
    {1, 0},
    {-1, 1},
    {0, 1},
    {1, 1}
  ]
  def get_neighbours({x, y}, state) do
    @neighbours
    |> Enum.map(fn {dx, dy} -> State.get(state, {x + dx, y + dy}) end)
    |> Enum.count(&(&1 == ?#))
  end

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
    |> Enum.with_index()
    |> Enum.map(&do_parse/1)
  end

  defp do_parse({chars, y}) do
    chars
    |> Enum.with_index()
    |> Enum.map(fn {char, x} -> {{x, y}, char} end)
  end

  defmodule Printer do
    def print(%State{} = state) do
      Enum.map_join(state.y_range, "\n", fn y ->
        Enum.map_join(state.x_range, "", fn x ->
          [state.grid[{x, y}]]
        end)
      end)
    end
  end
end

defimpl Inspect, for: Adventofcode.Day11SeatingSystem.State do
  import Inspect.Algebra

  alias Adventofcode.Day11SeatingSystem.{Printer, State}

  def inspect(%State{} = state, _opts) do
    concat([
      "#State{#{state.step} ",
      break(),
      to_string(Printer.print(state)),
      break(),
      "}"
    ])
  end
end
