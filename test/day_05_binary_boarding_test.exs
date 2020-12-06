defmodule Adventofcode.Day05BinaryBoardingTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day05BinaryBoarding
  import Adventofcode.Day05BinaryBoarding.Part1

  alias Adventofcode.Day05BinaryBoarding.Seat

  describe "part_1/1" do
    @boarding_pass "FBFBBFFRLR"
    test "consider just the first seven characters of FBFBBFFRLR" do
      assert [%Seat{front: 0..127} = seat, pass] = [%Seat{}, @boarding_pass]
      assert [%Seat{front: 0..63} = seat, pass] = [seat, pass] |> step
      assert [%Seat{front: 32..63} = seat, pass] = [seat, pass] |> step
      assert [%Seat{front: 32..47} = seat, pass] = [seat, pass] |> step
      assert [%Seat{front: 40..47} = seat, pass] = [seat, pass] |> step
      assert [%Seat{front: 44..47} = seat, pass] = [seat, pass] |> step
      assert [%Seat{front: 44..45} = seat, pass] = [seat, pass] |> step
      assert [%Seat{front: 44..44}, _pass] = [seat, pass] |> step
    end

    test "consider just the last 3 characters of FBFBBFFRLR" do
      assert [%Seat{front: 44..44, left: 0..7} = seat, pass] =
               [%Seat{}, @boarding_pass] |> step |> step |> step |> step |> step |> step |> step

      assert [%Seat{left: 4..7} = seat, pass] = [seat, pass] |> step
      assert [%Seat{left: 4..5} = seat, pass] = [seat, pass] |> step
      assert [%Seat{left: 5..5}, _pass] = [seat, pass] |> step
    end

    test "the seat has ID 44 * 8 + 5 = 357" do
      assert 357 = @boarding_pass |> locate |> Seat.pos() |> unique_seat_id
    end

    test_with_puzzle_input do
      assert 816 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test_with_puzzle_input do
      assert 539 = puzzle_input() |> part_2()
    end
  end
end
