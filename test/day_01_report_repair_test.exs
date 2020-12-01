defmodule Adventofcode.Day01ReportRepairTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day01ReportRepair

  @example_input """
  1721
  979
  366
  299
  675
  1456
  """

  describe "part_1/1" do
    test "pair that sums to 2020" do
      assert 514_579 = @example_input |> String.trim() |> part_1()
    end

    test_with_puzzle_input do
      assert 440_979 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test "triplet that sums to 2020" do
      assert 241_861_950 = @example_input |> String.trim() |> part_2()
    end

    test_with_puzzle_input do
      assert 82_498_112 = puzzle_input() |> part_2()
    end
  end
end
