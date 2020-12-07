defmodule Adventofcode.Day07HandyHaversacks do
  use Adventofcode

  alias __MODULE__.{Graph, Parser}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Graph.new()
    |> Graph.search()
    |> Enum.count
  end

  # def part_2(input) do
  #   input
  # end

  defmodule Graph do
    defstruct [:g, :bags]

    @top "shiny gold"

    def new(bags) do
      graph = %__MODULE__{g: :digraph.new(), bags: bags}

      :digraph.add_vertex(graph.g, @top, 1)

      Enum.each(bags, &add_bag(graph, &1))

      graph
    end

    def search(%Graph{} = graph) do
      graph.bags
      |> Enum.filter(fn [bag | _] -> bag != @top end)
      |> Enum.map(fn [bag | _] -> :digraph.get_path(graph.g, bag, @top) end)
      |> Enum.filter(& &1 != false)
    end

    defp add_bag(%Graph{} = graph, [bag | rules]) do
      :digraph.add_vertex(graph.g, bag, 1)

      Enum.each(rules, fn [quantity, bag2] ->
        :digraph.add_vertex(graph.g, bag2)
        :digraph.add_edge(graph.g, bag, bag2, quantity)
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
