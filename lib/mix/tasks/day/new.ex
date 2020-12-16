defmodule Mix.Tasks.Day.New do
  @moduledoc """
  Generate module for a day with a name and read puzzle input from STDIN
  """

  def run([name]) do
    module_name = Macro.camelize(name)

    create_input_file(name)
    create_lib_file(name, module_name)
    create_spec_file(name, module_name)
  end

  defp create_input_file(name) do
    File.write("input/#{name}.txt", IO.read(:stdio, :all))
  end

  defp create_lib_file(name, module_name) do
    contents = generate_lib_file(name, module_name)
    File.write("lib/#{name}.ex", contents)
  end

  defp create_spec_file(name, module_name) do
    contents = generate_spec_file(name, module_name)
    File.write("test/#{name}_test.exs", contents)
  end

  defp generate_lib_file(_name, module_name) do
    """
    defmodule Adventofcode.#{module_name} do
      use Adventofcode

      alias __MODULE__.{Parser, Part1, State}

      def part_1(input) do
        input
        |> Parser.parse()
        |> State.new
        |> Part1.solve()
      end

      # def part_2(input) do
      #   input
      #   |> Parser.parse()
      #   |> State.new
      #   |> Part2.solve()
      # end
      #

      defmodule State do
        @enforce_keys []
        defstruct pos: {0, 0}

        def new(_data), do: %__MODULE__{}
      end

      defmodule Part1 do
        def solve(state) do
          state
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
          |> String.trim()
          |> String.split("\\n")
          |> Enum.map(&parse_line/1)
        end

        defp parse_line(line) do
          line
        end
      end
    end
    """
  end

  defp generate_spec_file(_name, module_name) do
    '''
    defmodule Adventofcode.#{module_name}Test do
      use Adventofcode.FancyCase

      import Adventofcode.#{module_name}

      alias Adventofcode.#{module_name}.{Parser}

      @example"""
      """

      # @example2"""
      # """

      describe "part_1/1" do
        test "" do
          assert 1337 = @example |> part_1()
        end

        # test "" do
        #   assert 1337 = @example2 |> part_1()
        # end

        test_with_puzzle_input do
          assert 1337 = puzzle_input() |> part_1()
        end
      end

      describe "part_2/1" do
        # test "" do
        #   assert 1337 = @example |> part_2()
        # end

        # test "" do
        #   assert 1337 = @example2 |> part_2()
        # end

        # test_with_puzzle_input do
        #   assert 1337 = puzzle_input() |> part_2()
        # end
      end

      describe "Parser.parse/1" do
        test "parses input" do
          assert [1337] = @example |> Parser.parse()
        end
      end
    end
    '''
  end
end
