defmodule Adventofcode.Day11SeatingSystemTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day11SeatingSystem

  alias Adventofcode.Day11SeatingSystem.{Printer, State}

  @layouts """
  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL

  #.##.##.##
  #######.##
  #.#.#..#..
  ####.##.##
  #.##.##.##
  #.#####.##
  ..#.#.....
  ##########
  #.######.#
  #.#####.##

  #.LL.L#.##
  #LLLLLL.L#
  L.L.L..L..
  #LLL.LL.L#
  #.LL.LL.LL
  #.LLLL#.##
  ..L.L.....
  #LLLLLLLL#
  #.LLLLLL.L
  #.#LLLL.##

  #.##.L#.##
  #L###LL.L#
  L.#.#..#..
  #L##.##.L#
  #.##.LL.LL
  #.###L#.##
  ..#.#.....
  #L######L#
  #.LL###L.L
  #.#L###.##

  #.#L.L#.##
  #LLL#LL.L#
  L.L.L..#..
  #LLL.##.L#
  #.LL.LL.LL
  #.LL#L#.##
  ..L.L.....
  #L#LLLL#L#
  #.LLLLLL.L
  #.#L#L#.##

  #.#L.L#.##
  #LLL#LL.L#
  L.#.L..#..
  #L##.##.L#
  #.#L.LL.LL
  #.#L#L#.##
  ..L.L.....
  #L#L##L#L#
  #.LLLLLL.L
  #.#L#L#.##
  """

  describe "part_1/1" do
    test "get_neighbours/2" do
      dummy = """
      ##L
      #L#
      .#.
      """

      assert 5 = get_neighbours({1, 1}, dummy |> parse() |> State.new(tolerant: false))
    end

    test "once people stop moving around, you count 37 occupied seats." do
      [input | layouts] = @layouts |> String.trim_trailing() |> String.split("\n\n")
      initial = input |> parse() |> State.new(tolerant: false)

      result =
        Enum.reduce(layouts, initial, fn expected, state ->
          next = state |> step
          actual = Printer.print(next)

          assert actual == expected, """
          Expected:

          #{expected}

          but was:

          #{actual}
          """

          next
        end)

      assert 37 = State.count_occupied(result)
    end

    @tag :slow
    test_with_puzzle_input do
      assert 2249 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    @example """
    .......#.
    ...#.....
    .#.......
    .........
    ..#L....#
    ....#....
    .........
    #........
    ...#.....
    """
    test "the empty seat below would see eight occupied seats" do
      assert 8 = get_occupied_visible({3, 4}, @example |> parse() |> State.new(tolerant: true))
    end

    @example """
    .##.##.
    #.#.#.#
    ##...##
    ...L...
    ##...##
    #.#.#.#
    .##.##.
    """
    test "empty seat below would see no occupied seats" do
      assert 0 = get_occupied_visible({3, 3}, @example |> parse() |> State.new(tolerant: true))
    end

    test "people stop shifting around and the seating area reaches equilibrium. you count 26 occupied seats" do
      input = @layouts |> String.split("\n\n") |> hd()

      assert 26 = input |> part_2
    end

    @tag :slow
    test_with_puzzle_input do
      assert 2023 = puzzle_input() |> part_2()
    end
  end
end
