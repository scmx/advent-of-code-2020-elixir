defmodule Adventofcode.Day12RainRiskTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day12RainRisk

  alias Adventofcode.Day12RainRisk.{Captain, State}

  @example """
  F10
  N3
  F7
  R90
  F11
  """

  describe "part_1/1" do
    test "at the end of these instructions, the ship's position is 17 + 8 = 25" do
      assert 25 = @example |> part_1()
    end

    test "N1 results in north 1" do
      assert State.part_1(ship: {0, 1}) == Captain.operate(["N1"], State.part_1())
    end

    test "S1 results in north -1" do
      assert State.part_1(ship: {0, -1}) == Captain.operate(["S1"], State.part_1())
    end

    test "E1 results in east 1" do
      assert State.part_1(ship: {1, 0}) == Captain.operate(["E1"], State.part_1())
    end

    test "W1 results in east -1" do
      assert State.part_1(ship: {-1, 0}) == Captain.operate(["W1"], State.part_1())
    end

    test "R90 results in direction south" do
      assert State.part_1(waypoint: {0, -1}) == Captain.operate(["R90"], State.part_1())
    end

    test "L90 results in direction north" do
      assert State.part_1(waypoint: {0, 1}) == Captain.operate(["L90"], State.part_1())
    end

    test "F1 results in east 1" do
      assert State.part_1(ship: {1, 0}) == Captain.operate(["F1"], State.part_1())
    end

    test_with_puzzle_input do
      assert 2297 = puzzle_input() |> part_1()
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
