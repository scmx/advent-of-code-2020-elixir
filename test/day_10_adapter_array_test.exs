defmodule Adventofcode.Day10AdapterArrayTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day10AdapterArray

  @example1 "16 10 15 5 1 11 7 19 6 12 4"

  @example2 "28 33 18 42 31 14 46 20 48 47 24 23 49 45 19 38 39 11 1 32 25 35 8 17 7 9 4 2 34 10 3"

  describe "part_1/1" do
    test "7 differences of 1 jolt and 5 differences of 3 jolts" do
      assert 35 = @example1 |> part_1()
    end

    test_with_puzzle_input do
      assert 2590 = puzzle_input() |> part_1()
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
