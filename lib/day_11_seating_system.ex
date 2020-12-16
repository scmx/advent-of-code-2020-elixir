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

  def part_2(input) do
    input
    |> parse()
    |> State.new(tolerant: true)
    |> step_until_stable
    |> State.count_occupied()
  end

  defmodule State do
    @enforce_keys [:grid, :x_range, :y_range, :tolerant]
    defstruct grid: %{}, x_range: 0..0, y_range: 0..0, step: 0, tolerant: false

    def new(grid, options) do
      width = grid |> hd |> Enum.count()
      height = grid |> Enum.count()
      tolerant = Keyword.get(options, :tolerant, false)

      %__MODULE__{
        grid: grid |> List.flatten() |> Enum.into(%{}),
        x_range: 0..(width - 1),
        y_range: 0..(height - 1),
        tolerant: tolerant
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

  def step(%State{step: step} = state) do
    state.grid
    |> Enum.map(&find_neighbours(state, &1))
    |> Enum.reduce(%{state | step: step + 1}, &check/2)
  end

  defp find_neighbours(%State{tolerant: true} = state, {{x, y}, char}),
    do: {{x, y}, char, get_occupied_visible({x, y}, state)}

  defp find_neighbours(%State{} = state, {{x, y}, char}),
    do: {{x, y}, char, get_neighbours({x, y}, state)}

  defp check({_pos, ?., _}, acc), do: acc
  defp check({pos, ?L, 0}, acc), do: State.put(acc, pos, ?#)
  defp check({pos, ?#, n}, %{tolerant: false} = acc) when n >= 4, do: State.put(acc, pos, ?L)
  defp check({pos, ?#, n}, acc) when n >= 5, do: State.put(acc, pos, ?L)
  defp check({_pos, _, _}, acc), do: acc

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

  def get_occupied_visible({x, y}, state) do
    @neighbours
    |> Enum.count(&find_occupied?({x, y}, &1, state))
  end

  defp find_occupied?({x, y}, {dx, dy}, state) do
    pos = {x + dx, y + dy}

    case State.get(state, pos) do
      nil -> false
      ?# -> true
      ?L -> false
      ?. -> find_occupied?(pos, {dx, dy}, state)
    end
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
