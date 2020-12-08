defmodule Adventofcode.Day08HandheldHalting do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part1.run()
    |> State.accumulator()
  end

  defmodule State do
    defstruct accumulator: 0,
              instruction: 0,
              program: %{},
              history: MapSet.new(),
              loop: false

    def new(%{} = program) do
      %__MODULE__{program: program}
    end

    def accumulator(%State{accumulator: accumulator}), do: accumulator

    def accumulator(%State{} = state, change) do
      %{state | accumulator: state.accumulator + change}
    end

    def instruction(%State{instruction: instruction, history: history} = state, offset) do
      %{state | instruction: instruction + offset, history: MapSet.put(history, instruction)}
    end

    def acc(%State{} = state, argument) do
      state
      |> accumulator(argument)
      |> instruction(+1)
    end

    def jmp(%State{} = state, offset) do
      state
      |> instruction(offset)
    end

    def nop(%State{} = state, _argument) do
      state
      |> instruction(+1)
    end
  end

  defmodule Part1 do
    def run(%State{} = state) do
      cond do
        state.instruction in state.history ->
          %{state | loop: true}

        {operation, argument} = Map.get(state.program, state.instruction) ->
          apply(State, operation, [state, argument])
          |> run()
      end
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&parse_instruction/1)
      |> Enum.with_index()
      |> Enum.map(fn {instruction, index} -> {index, instruction} end)
      |> Enum.into(%{})
    end

    defp parse_instruction(line) do
      line
      |> String.split(" ")
      |> do_parse_instruction
    end

    defp do_parse_instruction([operation, argument]) do
      {String.to_atom(operation), String.to_integer(argument)}
    end
  end
end
