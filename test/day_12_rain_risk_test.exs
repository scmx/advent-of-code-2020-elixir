defmodule Adventofcode.Day12RainRiskTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day12RainRisk

  alias Adventofcode.Day12RainRisk.{Part1}

  describe "part_1/1" do
    @example """
    F10
    N3
    F7
    R90
    F11
    """
    test "At the end of these instructions, the ship's position is 17 + 8 = 25" do
      assert 25 = @example |> part_1()
    end

    test "moving N1 results in %{north: 1}" do
      assert %{north: 1} = "N1" |> parse |> travel(Part1)
    end

    test "moving S1 results in %{north: -1}" do
      assert %{north: -1} = "S1" |> parse |> travel(Part1)
    end

    test "moving E1 results in %{east: 1}" do
      assert %{east: 1} = "E1" |> parse |> travel(Part1)
    end

    test "moving W1 results in %{east: -1}" do
      assert %{east: -1} = "W1" |> parse |> travel(Part1)
    end

    test "moving R90 results in %{direction: :south}" do
      assert %{direction: :south} = "R90" |> parse |> travel(Part1)
    end

    test "moving L90 results in %{direction: :north}" do
      assert %{direction: :north} = "L90" |> parse |> travel(Part1)
    end

    test "moving F1 results in %{east: 1}" do
      assert %{east: 1} = "F1" |> parse |> travel(Part1)
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
