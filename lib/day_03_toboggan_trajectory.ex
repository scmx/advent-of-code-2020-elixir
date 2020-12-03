defmodule Adventofcode.Day03TobogganTrajectory do
  use Adventofcode

  require Logger

  alias __MODULE__.Grid

  def part_1(input) do
    input
    |> parse()
    |> traverse_all([%{x: 3, y: 1}])
  end

  def part_2(input) do
    input
    |> parse()
    |> traverse_all([%{x: 1, y: 1}, %{x: 3, y: 1}, %{x: 5, y: 1}, %{x: 7, y: 1}, %{x: 1, y: 2}])
  end

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_char_list/1)
    |> Grid.new()
  end

  defmodule Grid do
    @enforce_keys [:list, :size]
    defstruct list: [], size: %{x: 0, y: 0}, pos: %{x: 0, y: 0}, result: 0

    def new(list) do
      %__MODULE__{list: list, size: %{x: list |> hd() |> length, y: list |> length()}}
    end
  end

  def traverse_all(grid, slopes) do
    Enum.map(slopes, &traverse(grid, &1))
    |> Enum.map(&Map.get(&1, :result))
    |> Enum.reduce(&(&1 * &2))
  end

  def traverse(%Grid{pos: %{y: y}, size: %{y: height}} = grid, %{y: y_slope})
      when y + y_slope > height,
      do: grid

  def traverse(grid, slope) do
    grid
    |> increment_result()
    |> apply_slope(slope)
    |> traverse(slope)
  end

  defp apply_slope(grid, slope) do
    %{grid | pos: %{x: grid.pos.x + slope.x, y: grid.pos.y + slope.y}}
  end

  defp increment_result(grid) do
    list_item = grid.list |> Enum.at(grid.pos.y)
    x_index = rem(grid.pos.x, grid.size.x)

    case list_item |> Enum.at(x_index) do
      ?# -> %{grid | result: grid.result + 1}
      ?. -> grid
    end
  end
end
