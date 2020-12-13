defmodule Advent.Day5.Seat do
  defstruct row: 0, column: 0, id: 0

  def new(binary) do
    row = find_row(String.slice(binary, 0..6))
    column = find_column(String.slice(binary, 7..9))

    %__MODULE__{row: row, column: column, id: (row * 8) + column}
  end

  def find_column(column) do
    column
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> Enum.reduce(0..7, fn (char, min..max) ->
        case char do
          "L" -> min..(min + trunc((max - min) / 2))
          "R" -> (min + round((max - min) / 2))..max
        end
      end)
      |> (fn (min.._max) -> min end).()
  end

  def find_row(row) do
    row
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
      |> Enum.reduce(0..127, fn (char, min..max) ->
        case char do
          "F" -> min..(min + trunc((max - min) / 2))
          "B" -> (min + round((max - min) / 2))..max
        end
      end)
      |> (fn (min.._max) -> min end).()
  end
end

defmodule Advent.Day5.SeatFinder do
  alias Advent.Day5.Seat

  def highest_id(input) do
    input
      |> parse_input()
      |> Enum.sort(&(&1.id >= &2.id))
      |> List.first()
      |> (fn (seat) -> seat.id end).()
  end

  def missing_seat(input) do
    input
      |> parse_input()
      |> Enum.sort(&(&1.id >= &2.id))
      |> Enum.reduce_while(-1, fn (seat, last_id) ->
        case seat.id + 1 do
          ^last_id -> {:cont, seat.id}
          _ -> case last_id do
            -1 -> {:cont, seat.id}
            _ -> {:halt, seat.id + 1}
          end
        end
      end)
      |> IO.inspect
  end

  def parse_input(input) do
    input
      |> String.split("\n")
      |> Enum.map(&(String.trim(&1)))
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&(Seat.new(&1)))
  end
end
