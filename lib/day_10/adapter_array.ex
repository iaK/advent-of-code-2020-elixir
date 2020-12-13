defmodule Advent.Day10.AdapterArray do
  def parse_input(input) do
    input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&(String.trim(&1)))
      |> Enum.map(&String.to_integer(&1))
  end

  def find_jumps(input) do
    res = input
      |> parse_input()
      |> Enum.sort
      |> Enum.reduce(%{one: 0, three: 0, prev: 0}, fn (num, %{one: one, three: three, prev: prev}) ->
        case abs(prev - num) do
          1 -> %{one: one + 1, three: three, prev: num}
          3 -> %{one: one, three: three + 1, prev: num}
        end
      end)

    %{one: res.one, three: res.three + 1}
  end

  def all_possible_combinations_count(input) do
    input = input |> parse_input()

    input
      |> Enum.sort
      |> (fn (list) -> [0 | list] ++ [List.last(list) + 3] end).()
      |> find_ranges
      |> Enum.map(fn (range) ->
        possible_combinations_in_range([], range)
          |> Enum.reject(&(List.first(&1) - 2 > List.first(range)))
          |> Enum.reject(&(List.last(&1) + 2 < List.last(range)))
          |> Enum.count()
      end)
      |> Enum.reduce(fn (item, carry) -> item * carry end)
  end

  def find_ranges(input) do
    input
      |> Enum.reduce({0, [], []}, fn (item, {prev, seq, seqs}) ->
        case item - 1 == prev do
          true -> {item, [item | seq], seqs}
          false -> {item, [], [seq | seqs]}
        end
      end)
      |> (fn ({_, _, seqs}) -> seqs end).()
      |> Enum.reject(&(&1 == []))
      |> Enum.map(&(Enum.reverse(&1)))
      |> Enum.reverse
  end

  def possible_combinations_in_range(numbers, range) do
    case range do
      [] -> numbers |> Enum.reverse
      _ -> range
          |> Enum.with_index()
          |> Enum.map(fn ({number, index}) ->
            case Enum.at(range, index, 0) - number > 3 do
              true -> []
              false -> possible_combinations_in_range([number | numbers], Enum.slice(range, index + 1, Enum.count(range)))
            end
          end)
          |> flatten
          |> Enum.reject(&(&1 == []))
    end
  end

  def flatten(list, acc \\ []) when is_list(list) do
    unless list |> Enum.all?(&is_list(&1)) do
      acc ++ [list]
    else
      list |> Enum.reduce(acc, fn e, acc -> acc ++ flatten(e) end)
    end
  end

  # def possible_combinations_in_range(number, range) do
  #   range
  #    |>
  # end
end
