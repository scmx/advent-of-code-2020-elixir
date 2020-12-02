defmodule Mix.Tasks.Day.New do
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

      def part_1(input) do
        input
      end

      # def part_2(input) do
      #   input
      # end

      defp parse(input) do
        input
      end
    end
    """
  end

  defp generate_spec_file(_name, module_name) do
    """
    defmodule Adventofcode.#{module_name}Test do
      use Adventofcode.FancyCase

      import Adventofcode.#{module_name}

      describe "part_1/1" do
        test "" do
          assert 1337 = 1337 |> part_1()
        end

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
    """
  end
end
