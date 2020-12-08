defmodule Adventofcode.Day08HandheldHaltingTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day08HandheldHalting

  @input """
  nop +0
  acc +1
  jmp +4
  acc +3
  jmp -3
  acc -99
  acc +1
  jmp -4
  acc +6
  """

  describe "part_1/1" do
    test "accumulator immediately before any instruction is executed a second time" do
      assert 5 = @input |> part_1()
    end

    test_with_puzzle_input do
      assert 1384 = puzzle_input() |> part_1()
    end
  end
end
