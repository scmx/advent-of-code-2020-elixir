defmodule Adventofcode.Day14DockingDataTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day14DockingData

  alias Adventofcode.Day14DockingData.Part2

  describe "part_1/1" do
    @example """
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
    """

    test "what is the sum of all values left in memory after it completes?" do
      assert 165 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 13_865_835_758_282 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    @example """
    mask = 000000000000000000000000000000X1001X
    mem[42] = 100
    mask = 00000000000000000000000000000000X0XX
    mem[26] = 1
    """

    test "in this example, the sum is 208." do
      assert 208 = @example |> part_2()
    end

    test_with_puzzle_input do
      assert 4_195_339_838_136 = puzzle_input() |> part_2()
    end
  end

  describe "Part2.apply_floating" do
    test "000" do
      assert ["000"] = "000" |> Part2.apply_floating()
    end

    test "111" do
      assert ["111"] = "111" |> Part2.apply_floating()
    end

    test "00X" do
      assert ["000", "001"] = "00X" |> Part2.apply_floating()
    end

    test "X0X" do
      assert ["000", "001", "100", "101"] = "X0X" |> Part2.apply_floating()
    end

    test "XXX" do
      assert ["000", "001", "010", "011", "100", "101", "110", "111"] =
               "XXX" |> Part2.apply_floating()
    end
  end
end
