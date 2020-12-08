defmodule Adventofcode.Day08HandheldHalting do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, Part2, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part1.run()
    |> State.accumulator()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part2.run()
    |> State.accumulator()
  end

  defmodule State do
    defstruct accumulator: 0, index: 0, program: %{}, history: MapSet.new(), done: false

    def new(%{} = program), do: %__MODULE__{program: program}

    def accumulator(%State{accumulator: accumulator}), do: accumulator
  end

  defmodule Part1 do
    def run(%State{accumulator: acc} = state) do
      if state.index in state.history do
        %{state | done: :infinite_loop}
      else
        state = %{state | history: MapSet.put(state.history, state.index)}

        case Map.get(state.program, state.index) do
          nil -> %{state | done: :halt}
          {:acc, amount} -> run(%{state | index: state.index + 1, accumulator: acc + amount})
          {:jmp, offset} -> run(%{state | index: state.index + offset})
          {:nop, _value} -> run(%{state | index: state.index + 1})
        end
      end
    end
  end

  defmodule Part2 do
    def run(%State{} = state) do
      state.program
      |> Enum.filter(fn {_, {op, _}} -> op != :acc end)
      |> Enum.map(fn
        {index, {:jmp, arg}} -> Map.put(state.program, index, {:nop, arg})
        {index, {:nop, arg}} -> Map.put(state.program, index, {:jmp, arg})
      end)
      |> Enum.map(&Part1.run(%{state | program: &1}))
      |> Enum.find(&(&1.done == :halt))
    end
  end

  defmodule Parser do
    def parse(input) do
      ~r/(\w{3}) (\+?-?\d+)/
      |> Regex.scan(input)
      |> Enum.with_index()
      |> Enum.map(fn {[_, op, arg], index} ->
        {index, {String.to_atom(op), String.to_integer(arg)}}
      end)
      |> Enum.into(%{})
    end
  end
end
