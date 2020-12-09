defmodule Adventofcode.Day09EncodingErrorTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day09EncodingError

  @example "35 20 15 25 47 40 62 55 65 95 102 117 150 182 127 219 299 277 309 576"

  describe "part_1/1" do
    test "first number that does not have this property?" do
      assert 127 = @example |> part_1(5)
    end

    test_with_puzzle_input do
      assert 675_280_050 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test "encryption weakness in your XMAS-encrypted list of numbers?" do
      assert 62 = @example |> part_2(5)
    end

    @tag :slow
    test_with_puzzle_input do
      assert 96_081_673 = puzzle_input() |> part_2()
    end
  end
end
