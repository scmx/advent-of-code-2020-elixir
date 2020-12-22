defmodule Adventofcode.Day22CrabCombatTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day22CrabCombat

  alias Adventofcode.Day22CrabCombat.{Parser}

  @example """
  Player 1:
  9
  2
  6
  3
  1

  Player 2:
  5
  8
  4
  7
  10
  """

  describe "part_1/1" do
    test "once the game ends, the winning player's score is 306" do
      assert 306 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 34005 = puzzle_input() |> part_1()
    end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      assert [[9, 2, 6, 3, 1], [5, 8, 4, 7, 10]] = @example |> Parser.parse()
    end
  end
end
