defmodule Advent.Day11.SeatingSystemTest do
  use ExUnit.Case
  alias Advent.Day11.SeatingSystem

  test "it can find the number of occupied seats after it stables" do
    assert SeatingSystem.occupied_seats_at_stable("
      L.LL.LL.LL
      LLLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLLL
      L.LLLLLL.L
      L.LLLLL.LL
    ") == 37
  end
end
