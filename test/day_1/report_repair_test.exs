defmodule Day1.RocketEquationTest do
  use ExUnit.Case
  alias Advent.Day1.ReportRepair

  test "it can get the product of two numbers that sums to a number" do
    assert ReportRepair.find_expense_product("
      12
      23
      34
      48
    ", 57, 2) == 782
  end

  test "it can get the product of three numbers that sums to a number" do
    assert ReportRepair.find_expense_product("
      23
      42
      54
      72
      37
      85
      31
    ", 164, 3) == 132090
  end
end
