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
               ["light red", ["1", "bright white"], ["2", "muted yellow"]],
               ["dark orange", ["3", "bright white"], ["4", "muted yellow"]],
               ["bright white", ["1", "shiny gold"]],
               ["muted yellow", ["2", "shiny gold"], ["9", "faded blue"]],
               ["shiny gold", ["1", "dark olive"], ["2", "vibrant plum"]],
               ["dark olive", ["3", "faded blue"], ["4", "dotted black"]],
               ["vibrant plum", ["5", "faded blue"], ["6", "dotted black"]],
               ["faded blue"],
               ["dotted black"]
             ] = @input |> Parser.parse()
    end

    test "bag colors that can eventually contain at least one shiny gold bag is 4" do
      assert [
               ["light red", ["1", "bright white"], ["2", "muted yellow"]],
               ["dark orange", ["3", "bright white"], ["4", "muted yellow"]],
               ["bright white", ["1", "shiny gold"]],
               ["muted yellow", ["2", "shiny gold"], ["9", "faded blue"]],
               ["shiny gold", ["1", "dark olive"], ["2", "vibrant plum"]],
               ["dark olive", ["3", "faded blue"], ["4", "dotted black"]],
               ["vibrant plum", ["5", "faded blue"], ["6", "dotted black"]],
               ["faded blue"],
               ["dotted black"]
             ] = @input |> part_1
    end

    @tag :skip
    test_with_puzzle_input do
      assert 1337 = puzzle_input() |> part_1()
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
