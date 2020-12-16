defmodule Adventofcode.Day16TicketTranslationTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day16TicketTranslation

  describe "part_1/1" do
    @example """
    class: 1-3 or 5-7
    row: 6-11 or 33-44
    seat: 13-40 or 45-50

    your ticket:
    7,1,14

    nearby tickets:
    7,3,47
    40,4,50
    55,2,20
    38,6,12
    """
    test "produces your ticket scanning error rate: 4 + 55 + 12 = 71" do
      assert 71 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 26980 = puzzle_input() |> part_1()
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
