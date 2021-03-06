defmodule Adventofcode.Day07HandyHaversacksTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day07HandyHaversacks

  alias Adventofcode.Day07HandyHaversacks.Parser

  @input """
  light red bags contain 1 bright white bag, 2 muted yellow bags.
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  bright white bags contain 1 shiny gold bag.
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  faded blue bags contain no other bags.
  dotted black bags contain no other bags.
  """

  describe "part_1/1" do
    test "parsing bag rules" do
      assert [
               ["light red", [1, "bright white"], [2, "muted yellow"]],
               ["dark orange", [3, "bright white"], [4, "muted yellow"]],
               ["bright white", [1, "shiny gold"]],
               ["muted yellow", [2, "shiny gold"], [9, "faded blue"]],
               ["shiny gold", [1, "dark olive"], [2, "vibrant plum"]],
               ["dark olive", [3, "faded blue"], [4, "dotted black"]],
               ["vibrant plum", [5, "faded blue"], [6, "dotted black"]],
               ["faded blue"],
               ["dotted black"]
             ] = @input |> Parser.parse()
    end

    test "bag colors that can eventually contain at least one shiny gold bag is 4" do
      assert 4 = @input |> part_1
    end

    test_with_puzzle_input do
      assert 335 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test "1 + 1*7 + 2 + 2*11 = 32 bags!" do
      assert 32 = @input |> part_2
    end

    @input """
    shiny gold bags contain 2 dark red bags.
    dark red bags contain 2 dark orange bags.
    dark orange bags contain 2 dark yellow bags.
    dark yellow bags contain 2 dark green bags.
    dark green bags contain 2 dark blue bags.
    dark blue bags contain 2 dark violet bags.
    dark violet bags contain no other bags.
    """

    test "a single shiny gold bag must contain 126 other bags" do
      assert 126 = @input |> part_2()
    end

    test_with_puzzle_input do
      assert 2431 = puzzle_input() |> part_2()
    end
  end
end
