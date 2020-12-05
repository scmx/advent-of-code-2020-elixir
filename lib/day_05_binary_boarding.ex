defmodule Adventofcode.Day05BinaryBoarding do
  use Adventofcode

  alias __MODULE__.{Part1, Printer, Seat}

  def part_1(input) do
    input
    |> parse
    |> Enum.map(&Part1.locate/1)
    |> Enum.map(&Seat.pos/1)
    |> Enum.map(&unique_seat_id/1)
    |> Enum.max()
  end

  defmodule Seat do
    defstruct front: 0..127, left: 0..7, done: false

    def pos(%Seat{front: front..front, left: left..left}), do: {front, left}
  end

  defmodule Part1 do
    def locate(pass) when is_binary(pass), do: [%Seat{}, pass] |> locate

    def locate([%Seat{} = seat, pass]) do
      case [seat, pass] |> step do
        [%Seat{done: true} = seat, _pass] -> seat
        [%Seat{} = seat, pass] -> [seat, pass] |> locate
      end
    end

    def step([%Seat{front: f..f, left: l..l} = seat, pass]) do
      [%{seat | done: true}, pass]
    end

    def step([%Seat{front: front, left: left} = seat, pass]) do
      case pass do
        "F" <> pass -> [%{seat | front: front |> lower_half}, pass]
        "B" <> pass -> [%{seat | front: front |> upper_half}, pass]
        "L" <> pass -> [%{seat | left: left |> lower_half}, pass]
        "R" <> pass -> [%{seat | left: left |> upper_half}, pass]
      end
    end

    def lower_half(low..high), do: low..div(low + high, 2)
    def upper_half(low..high), do: (div(low + high, 2) + 1)..high
  end

  def unique_seat_id({front, left}), do: front * 8 + left

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end
end
