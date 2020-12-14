defmodule Adventofcode.Day14DockingDataTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day14DockingData

  @example """
  mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
  mem[8] = 11
  mem[7] = 101
  mem[8] = 0
  """

  describe "part_1/1" do
    test "what is the sum of all values left in memory after it completes?" do
      assert 165 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 13_865_835_758_282 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    # test "" do
    #   assert 1337 = 1337 |> part_2()
    # end

    # test_with_puzzle_input do
    #   assert 1337 = puzzle_input() |> part_2()
    # end
  end
end
