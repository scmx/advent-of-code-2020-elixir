defmodule Adventofcode do
  @moduledoc """
  Base module for day solutions. By `use`ing this module a `puzzle_input/0`
  function will be provided that reads puzzle input to a string. Will probably
  only be used during tests
  """

  defmacro __using__(options) do
    quote do
      import Adventofcode
      @moduledoc "Solution for Advent of Code 2020 #{module_pretty(__MODULE__)}"

      def puzzle_input do
        read_puzzle_input_for(__MODULE__, unquote(options))
      end
    end
  end

  @doc false
  def read_puzzle_input_for(module, options) when is_atom(module) do
    module
    |> input_filename
    |> read_puzzle_input_for(options)
  end

  def read_puzzle_input_for(filename, options) when is_binary(filename) do
    case File.read(Path.join(["input", filename <> ".txt"])) do
      {:ok, data} -> trim(data, Keyword.get(options, :trim))
      {:error, _} -> nil
    end
  end

  defp trim(text, false), do: String.trim_trailing(text, "\n")
  defp trim(text, _), do: String.trim(text)

  defp input_filename(module) do
    module
    |> to_string()
    |> String.split(".")
    |> Enum.at(2)
    |> Macro.underscore()
    |> String.replace(~r/(\w)(\d)/, "\\1_\\2")
  end

  defmacro module_pretty({:__MODULE__, [line: _, counter: {module, _}], _}) do
    module
    |> to_string()
    |> String.split(".")
    |> Enum.at(2)
    |> Macro.underscore()
    |> String.replace(~r/(\w)(\d)/, "\\1_\\2")
    |> String.replace("_", " ")
  end
end
