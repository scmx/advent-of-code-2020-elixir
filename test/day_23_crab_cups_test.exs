defmodule Adventofcode.Day23CrabCupsTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day23CrabCups

  alias Adventofcode.Day23CrabCups.{Parser, Part1}

  @example "389125467"

  describe "part_1/1" do
    test "after 10 moves, the cups clockwise from 1 are labeled 92658374" do
      assert 92_658_374 = @example |> Parser.parse() |> Part1.solve(10)
    end

    test "after 100 moves, the order after cup 1 would be 67384529" do
      assert 67_384_529 = @example |> part_1
    end

    test_with_puzzle_input do
      assert 45_798_623 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    # test "" do
    #   assert 1337 = @example |> part_2()
    # end

    # test "" do
    #   assert 1337 = @example2 |> part_2()
    # end

    # test_with_puzzle_input do
    #   assert 1337 = puzzle_input() |> part_2()
    # end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      assert %{
               1 => {9, 3, 2},
               2 => {1, 8, 3},
               3 => {2, 9, 4},
               4 => {3, 1, 5},
               5 => {4, 2, 6},
               6 => {5, 5, 7},
               7 => {6, 4, 8},
               8 => {7, 6, 9},
               9 => {8, 7, 1},
               :counter => 9,
               :current => 1,
               :size => 9
             } = @example |> Parser.parse()
    end
  end
end
