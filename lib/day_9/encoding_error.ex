defmodule Advent.Day9.EncodingError do
  def parse_input(input) do
    input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.trim(&1))
      |> Enum.map(&String.to_integer(&1))
  end

  def failing_number(input) do
    input = input
      |> parse_input()

    input
      |> Enum.slice(25, Enum.count(input))
      |> Enum.with_index()
      |> Enum.reject(fn ({number, index}) ->
        can_be_summed_by_preamble(input, number, index)
      end)
      |> List.first
  end

  def range_adding_up_to_number(input, number) when is_binary(input) do
    range = range_adding_up_to_number(parse_input(input), number)
      |> Enum.sort

    [List.first(range), List.last(range)]
  end
  def range_adding_up_to_number([_head | tail] = input, number) do
    range = input
      |> Enum.reduce_while({:ok, nil}, fn (item, {_status, acc}) ->
          case acc do
            nil -> {:cont, {:ok, [item]}}
            _ -> case Enum.sum([item | acc]) do
              ^number -> {:halt, {:ok, [item | acc]}}
              _ -> {:cont, {:error, [item | acc]}}
            end
          end
        end)
        # |> IO.inspect

      case range do
        {:error, _} -> range_adding_up_to_number(tail, number)
        {:ok, range} -> range
      end
  end

  def can_be_summed_by_preamble(input, result, index) do
    input = input
      |> Enum.slice(index, 25)

    input
      |> Enum.with_index()
      |> Enum.any?(fn ({number, index}) ->
        input
          |> Enum.slice(index, 25)
          |> Enum.any?(&(&1 + number == result))
      end)
  end
end
