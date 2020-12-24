defmodule Adventofcode.Day23CrabCups do
  use Adventofcode

  alias __MODULE__.{Parser, Part1}
  alias Adventofcode.Circle

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve(100)
  end

  # def part_2(input) do
  #   input
  #   |> Parser.parse()
  #   |> State.new
  #   |> Part2.solve()
  # end

  defmodule Part1 do
    def solve(circle, moves) do
      circle = Enum.reduce(1..moves, circle, &step/2)

      circle
      |> Circle.to_list()
      |> Enum.join("")
      |> String.split("1")
      |> Enum.reverse()
      |> Enum.join("")
      |> String.to_integer()
    end

    def step(move, circle) do
      current_val = circle |> Circle.current()

      cups =
        circle
        |> Circle.to_list()
        |> Enum.map(fn
          ^current_val -> "(#{current_val})"
          val -> " #{val} "
        end)

      {three, circle} = circle |> Circle.take_after(3)

      destination = circle |> find_destination

      circle =
        circle
        |> Circle.insert_after(three, destination)
        |> Circle.move_next()

      IO.puts("""
      -- move #{move} --
      cups: #{cups}
      pick up: #{three |> Enum.join(", ")}
      destination: #{circle |> Circle.at(destination)}
      """)

      circle
    end

    defp find_destination(circle) do
      all = circle |> Circle.all()
      current_val = circle |> Circle.current()

      [
        all
        |> Enum.filter(fn {_, val} -> val < current_val end)
        |> Enum.sort_by(fn {_, val} -> val end, :desc)
        |> Enum.map(fn {id, _} -> id end)
        |> Enum.take(1),
        all
        |> Enum.filter(fn {_, val} -> val > current_val end)
        |> Enum.sort_by(fn {_, val} -> val end, :desc)
        |> Enum.map(fn {id, _} -> id end)
        |> Enum.take(1)
      ]
      |> List.flatten()
      |> Enum.at(0)
    end
  end

  # defmodule Part2 do
  #   def solve(state) do
  #     state
  #   end
  # end

  defmodule Parser do
    def parse(input) do
      input
      |> String.to_charlist()
      |> Enum.map(&(&1 - ?0))
      |> Circle.new()
    end
  end
end
