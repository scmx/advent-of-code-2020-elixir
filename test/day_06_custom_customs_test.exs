defmodule Adventofcode.Day06CustomCustomsTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day06CustomCustoms

  describe "part_1/1" do
    @input """
    abcx
    abcy
    abcz
    """
    test "6 questions to which anyone answered yes: a, b, c, x, y, and z" do
      assert 6 = @input |> part_1()
    end

    @input """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """
    test "represents answers from five groups" do
      assert 11 = @input |> part_1()
    end

    test_with_puzzle_input do
      assert 6534 = puzzle_input() |> part_1()
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
