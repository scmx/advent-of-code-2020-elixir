defmodule Adventofcode.Day02PasswordPhilosophyTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day02PasswordPhilosophy

  @example_input """
  1-3 a: abcde
  1-3 b: cdefg
  2-9 c: ccccccccc
  """

  describe "part_1/1" do
    test "the first and third passwords are valid" do
      assert 2 = @example_input |> part_1()
    end

    test_with_puzzle_input do
      assert 515 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    # test "" do
    #   assert 1337 = 1337 |> part_1()
    # end

    # test_with_puzzle_input do
    #   assert 1337 = puzzle_input() |> part_1()
    # end
  end
end
