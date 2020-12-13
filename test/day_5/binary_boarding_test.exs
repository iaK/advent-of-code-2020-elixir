defmodule Day5.BinaryBoardingTest do
  use ExUnit.Case
  alias Advent.Day5.Seat
  alias Advent.Day5.SeatFinder

  test "it can find its row" do
    assert Seat.find_row("BFFFBBF") == 70
    assert Seat.find_row("FFFBBBF") == 14
    assert Seat.find_row("BBFFBBF") == 102
  end

  test "it can find its column" do
    assert Seat.find_column("RRR") == 7
    assert Seat.find_column("LLL") == 0
    assert Seat.find_column("RLL") == 4
  end

  test "it can convert its input to seats" do
    seats = assert SeatFinder.parse_input("
      BFFFBBFRRR
      FFFBBBFRRR
      BBFFBBFRLL
    ")

    assert [
      %Advent.Day5.Seat{column: 7, id: 567, row: 70},
      %Advent.Day5.Seat{column: 7, id: 119, row: 14},
      %Advent.Day5.Seat{column: 4, id: 820, row: 102}
    ] = seats
  end
end
