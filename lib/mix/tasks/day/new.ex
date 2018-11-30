defmodule Mix.Tasks.Day.New do
  def run([name, fun_name]) do
    module_name = Macro.camelize(name)

    create_input_file(name)
    create_lib_file(name, module_name, fun_name)
    create_spec_file(name, module_name, fun_name)
  end

  defp create_input_file(name) do
    File.write("input/#{name}.txt", IO.read(:stdio, :all))
  end

  defp create_lib_file(name, module_name, fun_name) do
    contents = generate_lib_file(name, module_name, fun_name)
    File.write("lib/#{name}.ex", contents)
  end

  defp create_spec_file(name, module_name, fun_name) do
    contents = generate_spec_file(name, module_name, fun_name)
    File.write("test/#{name}_test.exs", contents)
  end

  defp generate_lib_file(name, module_name, fun_name) do
    """
    defmodule Adventofcode.#{module_name} do
      def #{fun_name}(input) do
        input
      end
    end
    """
  end

  defp generate_spec_file(name, module_name, fun_name) do
    """
    defmodule Adventofcode.#{module_name}Test do
      use Adventofcode.FancyCase

      import Adventofcode.#{module_name}

      describe "#{fun_name}/1" do
        test "" do
          assert 1337 = input |> #{fun_name}()
        end

        test "with_puzzle_input" do
          with_puzzle_input("input/#{name}.txt", fn input ->
            assert 1337 = input |> #{fun_name}()
          end)
        end
      end
    end
    """
  end
end
