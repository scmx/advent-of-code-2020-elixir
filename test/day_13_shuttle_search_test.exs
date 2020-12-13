defmodule Adventofcode.Day13ShuttleSearchTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day13ShuttleSearch

  @example """
  939
  7,13,x,x,59,x,31,19
  """

  describe "part_1/1" do
    test "Multiplying the bus ID by the number of minutes you'd need to wait gives 295" do
      assert 295 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 1915 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    # test "" do
    #   assert 1337 = @example |> part_2()
    # end

    # test_with_puzzle_input do
    #   assert 1337 = puzzle_input() |> part_2()
    # end
  end
end
