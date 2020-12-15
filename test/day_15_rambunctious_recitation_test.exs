defmodule Adventofcode.Day15RambunctiousRecitationTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day15RambunctiousRecitation

  alias Adventofcode.Day15RambunctiousRecitation.Memory

  describe "part_1/1" do
    @example "0,3,6"
    @expected [0, 3, 6, 0, 3, 3, 1, 0, 4, 0]
    test "suppose the starting numbers are 0,3,6" do
      initial = @example |> parse |> Memory.new()
      memory = initial |> Memory.play()

      @expected
      |> Enum.with_index()
      |> Enum.map(fn {val, index} -> {val, index + 1} end)
      |> Enum.each(fn {expected, turn} ->
        assert expected == Memory.by_turn(memory, turn)
      end)

      assert 436 = memory |> Memory.by_turn(2020)
    end

    test_with_puzzle_input do
      assert 614 = puzzle_input() |> part_1()
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
