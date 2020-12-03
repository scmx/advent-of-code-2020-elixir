defmodule Adventofcode.Day03TobogganTrajectoryTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day03TobogganTrajectory

  alias Adventofcode.Day03TobogganTrajectory.Grid

  @example_input """
  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
  """

  describe "part_1/1" do
    test "parse map into list, width, height" do
      assert %Grid{
               list: ['..##.......', '#...#...#..', '.#....#..#.' | _],
               size: %{x: 11, y: 11}
             } = @example_input |> parse()
    end

    test "slope right 3, down 1" do
      grid = @example_input |> parse()
      assert %Grid{result: 7} = grid |> traverse(%{x: 3, y: 1})
    end

    test_with_puzzle_input do
      assert 191 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test "trees encountered on each of the listed slopes" do
      assert 336 = @example_input |> part_2()
    end

    test_with_puzzle_input do
      assert 1_478_615_040 = puzzle_input() |> part_2()
    end
  end
end
