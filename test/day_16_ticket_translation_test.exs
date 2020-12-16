defmodule Adventofcode.Day16TicketTranslationTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day16TicketTranslation

  alias Adventofcode.Day16TicketTranslation.{Parser, Part2}

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
      assert 26_980 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    @example """
    class: 0-1 or 4-19
    row: 0-5 or 8-19
    seat: 0-13 or 16-19

    your ticket:
    11,12,13

    nearby tickets:
    3,9,18
    15,1,5
    5,14,9
    """
    test "in your ticket, class is 12, row is 11, and seat is 13" do
      assert 1716 = @example |> Parser.parse() |> Part2.solve("")
    end

    test_with_puzzle_input do
      assert 3_021_381_607_403 = puzzle_input() |> part_2()
    end
  end
end
