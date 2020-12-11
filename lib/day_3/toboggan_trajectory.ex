defmodule Advent.Day3.PathFinder do
  def trees_hit(input, hits, row, col, row_increments \\ 1, col_increments \\ 3) when is_list(input) do
    width = input |> List.first |> String.length

    next_col = case col + col_increments >= width do
      true -> rem(col + col_increments, width)
      _ -> col + col_increments
    end

    case row >= Enum.count(input) do
        true -> hits
        _ -> case is_hit(input, row, col) do
          true -> trees_hit(input, hits + 1, row + row_increments, next_col, row_increments, col_increments)
          false -> trees_hit(input, hits, row + row_increments, next_col, row_increments, col_increments)
        end
    end
  end

  def trees_hit(input) when is_binary(input) do
    input
      |> parse_input
      |> trees_hit(0,0,0)
  end

  def trees_hit_in_more_slopes(input) when is_binary(input) do
    parsed = input |> parse_input
    [
      parsed |> trees_hit(0,0,0,1,1),
      parsed |> trees_hit(0,0,0,1,3),
      parsed |> trees_hit(0,0,0,1,5),
      parsed |> trees_hit(0,0,0,1,7),
      parsed |> trees_hit(0,0,0,2,1),
    ]
      |> IO.inspect
      |> Enum.reduce(fn (elem, acc) -> elem * acc end)
  end

  def is_hit(input, row, col) do
    input
      |> Enum.at(row)
      |> String.at(col) == "#"
  end

  def parse_input(input) do
    input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&(String.trim(&1)))
  end
end
