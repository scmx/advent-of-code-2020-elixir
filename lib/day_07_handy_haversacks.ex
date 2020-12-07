defmodule Adventofcode.Day07HandyHaversacks do
  use Adventofcode

  alias __MODULE__.{Graph, Parser}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Graph.new()
    |> Graph.search()
  end

  # def part_2(input) do
  #   input
  # end

  defmodule Graph do
    @spec new(any) :: :digraph.graph()
    def new(bags) do
      graph = :digraph.new([:acyclic])

      :digraph.add_vertex(graph, "shiny gold", 1)

      Enum.each(bags, &add_bag(graph, &1))

      graph
    end

    def search(graph) do
      :digraph_utils.arborescence_root(graph)
    end

    defp add_bag(graph, [bag | rules]) do
      :digraph.add_vertex(graph, bag, 1)

      Enum.each(rules, fn [quantity, bag2] ->
        :digraph.add_vertex(graph, bag2)
        :digraph.add_edge(graph, bag, bag2, quantity)
      end)
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
      |> Enum.map(&Enum.drop(&1, 1))
    end
  end
end
