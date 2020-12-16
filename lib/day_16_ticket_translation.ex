defmodule Adventofcode.Day16TicketTranslation do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, Part2}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Part2.solve()
  end

  defmodule Part1 do
    def solve([rules, _your_ticket, nearby_tickets]) do
      all_ranges = rules |> Enum.flat_map(&tl/1)

      nearby_tickets
      |> List.flatten()
      |> Enum.reject(fn num -> Enum.any?(all_ranges, &(num in &1)) end)
      |> Enum.sum()
    end
  end

  defmodule Part2 do
    def solve([rules, your_ticket, nearby_tickets], prefix \\ "departure") do
      all_ranges = rules |> Enum.flat_map(&tl/1)
      tickets = nearby_tickets |> Enum.filter(&valid_ticket?(&1, all_ranges))
      fields = possible_fields(tickets, rules)

      fields
      |> Enum.filter(&(&1 |> elem(1) |> String.starts_with?(prefix)))
      |> Enum.map(&elem(&1, 0))
      |> Enum.map(&Enum.at(your_ticket, &1))
      |> Enum.reduce(&Kernel.*/2)
    end

    defp possible_fields(tickets, rules) do
      tickets
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&matching_rules(&1, rules))
      |> Enum.with_index()
      |> (&rule_out_exact_order({&1, %{}})).()
    end

    defp rule_out_exact_order({[], result}) do
      Enum.sort_by(result, &elem(&1, 0))
    end

    defp rule_out_exact_order({possibilities, matched}) do
      possibilities
      |> Enum.map(&rule_out_already_matched_fields(&1, matched))
      |> Enum.filter(&(length(elem(&1, 0)) > 0))
      |> Enum.sort_by(&length(elem(&1, 0)))
      |> Enum.map_reduce(matched, &match_fields/2)
      |> rule_out_exact_order
    end

    defp match_fields({[name], index}, acc) do
      {{[name], index}, Map.put(acc, index, name)}
    end

    defp match_fields({choices, index}, acc), do: {{choices, index}, acc}

    defp rule_out_already_matched_fields({choices, index}, matched) do
      {Enum.reject(choices, &(&1 in Map.values(matched))), index}
    end

    defp valid_ticket?(ticket, all_ranges) do
      Enum.all?(ticket, fn num -> Enum.any?(all_ranges, &(num in &1)) end)
    end

    defp matching_rules(field_values, rules) do
      rules
      |> Enum.filter(&matching_rule?(&1, field_values))
      |> Enum.map(&hd/1)
    end

    defp matching_rule?([_name, range1, range2], field_values) do
      Enum.all?(field_values, &(&1 in range1 or &1 in range2))
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n\n")
      |> Enum.map(&parse_group/1)
    end

    defp parse_group("your ticket:" <> _ = group) do
      group
      |> String.split("\n")
      |> Enum.at(1)
      |> parse_ticket
    end

    defp parse_group("nearby tickets:" <> _ = group) do
      group
      |> String.split("\n")
      |> Enum.drop(1)
      |> Enum.map(&parse_ticket/1)
    end

    defp parse_group(group) do
      group
      |> String.split("\n")
      |> Enum.map(&Regex.split(~r/(: | or )/, &1))
      |> Enum.map(&[hd(&1) | parse_ranges(tl(&1))])
    end

    defp parse_ranges(ranges) do
      ranges
      |> Enum.map(&String.split(&1, "-"))
      |> Enum.map(&parse_range/1)
    end

    defp parse_range([a, b]), do: String.to_integer(a)..String.to_integer(b)

    defp parse_ticket(ticket) do
      ticket
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end
  end
end
