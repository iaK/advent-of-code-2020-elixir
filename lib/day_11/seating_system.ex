defmodule Advent.Day11.SeatingSystem do
  def occupied_seats_at_stable(input) do
    input = input
      |> parse_input()

    input
      |> Enum.reduce_while({input, ""}, fn (_input, {input, hash}) ->
        ticked = input |> tick

        hashed = ticked
          |> Enum.join("")
          |> (fn (joined) -> :crypto.hash(:sha, joined) end).()

        case hash == hashed do
          true -> {:halt, ticked}
          false -> {:cont, {ticked, hashed}}
        end
      end)
      |> Enum.join("")
      |> String.graphemes
      |> Enum.count(& &1 == "#")

  end
  def parse_input(input) do
    input
      |> String.trim()
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&parse_row(&1))
  end

  def tick(input) do
    input
      |> Enum.with_index()
      |> Enum.map(fn ({row, row_index}) ->
        row
          |> Enum.with_index()
          |> Enum.map(fn ({cell, cell_index}) ->
              new_state(cell, row_index, cell_index, input)
          end)
      end)
  end

  def new_state(".", _row_index, _cell_index, _input) do
    "."
  end
  def new_state("L", row_index, cell_index, input) do
    occupied = adjecent_seats(row_index, cell_index, input)
      |> Enum.filter(&(&1 == "#"))

    case occupied |> Enum.count == 0 do
      true -> "#"
      false -> "L"
    end
  end
  def new_state("#", row_index, cell_index, input) do
    occupied = adjecent_seats(row_index, cell_index, input)
      |> Enum.filter(&(&1 == "#"))

    case occupied |> Enum.count >= 4 do
      true -> "L"
      false -> "#"
    end
  end

  def adjecent_seats(row_index, cell_index, input) do
    [
      at(input, row_index - 1, []) |> at(cell_index - 1, nil),
      at(input, row_index - 1, []) |> at(cell_index, nil),
      at(input, row_index - 1, []) |> at(cell_index + 1, nil),
      at(input, row_index, []) |> at(cell_index - 1, nil),
      at(input, row_index, []) |> at(cell_index + 1, nil),
      at(input, row_index + 1, []) |> at(cell_index - 1, nil),
      at(input, row_index + 1, []) |> at(cell_index, nil),
      at(input, row_index + 1, []) |> at(cell_index + 1, nil),
    ]
  end

  def at(input, index, default) do
    case index < 0 do
      true -> default
      false -> Enum.at(input, index, default)
    end
  end

  def parse_row(row) do
    row
      |> String.trim()
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
  end
end
