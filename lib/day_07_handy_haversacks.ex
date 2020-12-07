defmodule Adventofcode.Day07HandyHaversacks do
  use Adventofcode

  alias __MODULE__.{Graph, Parser, Part1, Part2}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Graph.new()
    |> Part1.solve()
    |> Enum.count()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Graph.new()
    |> Part2.solve()
  end

  defmodule Graph do
    defstruct [:g, :bags]

    def new(bags) do
      graph = %__MODULE__{g: :digraph.new(), bags: bags}

      Enum.each(bags, &add_bag(graph, &1))

      graph
    end

    defp add_bag(%Graph{} = graph, [bag | rules]) do
      :digraph.add_vertex(graph.g, bag, 1)

      Enum.each(rules, fn [quantity, bag2] ->
        :digraph.add_vertex(graph.g, bag2)
        :digraph.add_edge(graph.g, {bag, bag2}, bag, bag2, quantity)
      end)
    end
  end

  defmodule Part1 do
    @top "shiny gold"

    def solve(%Graph{} = graph) do
      graph.bags
      |> Enum.filter(fn [bag | _] -> bag != @top end)
      |> Enum.map(fn [bag | _] -> :digraph.get_path(graph.g, bag, @top) end)
      |> Enum.filter(&(&1 != false))
    end
  end

  defmodule Part2 do
    @top "shiny gold"

    def solve(%Graph{} = graph) do
      graph
      |> paths({@top, 1})
      |> Enum.map(&quantities/1)
      |> Enum.map(&sum/1)
      |> :lists.flatten()
      |> Enum.sum()
    end

    defp paths(%Graph{} = graph, {vertex, _quantity}) do
      :digraph.edges(graph.g, vertex)
      |> Enum.filter(&(elem(&1, 0) == vertex))
      |> Enum.map(&:digraph.edge(graph.g, &1))
      |> Enum.map(fn {{_, _}, _, vertex, quantity} -> {vertex, quantity} end)
      |> Enum.map(&[&1 | paths(graph, &1)])
    end

    def quantities([{_vertex, quantity} | vertices]) do
      [quantity | vertices |> Enum.map(&quantities/1)]
    end

    def sum([quantity | quantities]) do
      [quantity | quantities |> Enum.map(fn [q | rest] -> sum([q * quantity | rest]) end)]
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&parse_line/1)
    end

    defp parse_line(line) do
      ~r/^(\w+ \w+) bags contain (.+)$/
      |> Regex.run(line)
      |> Enum.drop(1)
      |> do_parse_line
    end

    defp do_parse_line([bag, contents]) do
      [bag | parse_bag_contents(contents)]
    end

    defp parse_bag_contents(contents) do
      ~r/(\d+) (\w+ \w+)/
      |> Regex.scan(contents)
      |> Enum.map(fn [_, quantity, bag] -> [String.to_integer(quantity), bag] end)
    end
  end
end
