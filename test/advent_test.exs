defmodule AdventTest do
  use ExUnit.Case
  alias Advent.FileReader

  test "Day 1 - Report repair - part 1" do
    assert Advent.Day1.ReportRepair.find_expense_product(
      FileReader.get_input("lib/day_1/input.txt"),
      2020,
      2
    ) == 719796
  end

  test "Day 1 - Report repair - part 2" do
    assert Advent.Day1.ReportRepair.find_expense_product(
      FileReader.get_input("lib/day_1/input.txt"),
      2020,
      3
    ) == 144554112
  end

  test "Day 2 - Password philosophy - part 1" do
    assert Advent.Day2.PasswordValidator.valid_sled_rental_password_count(
      FileReader.get_input("lib/day_2/input.txt")
    ) == 454
  end

  test "Day 2 - Password philosophy - part 2" do
    assert Advent.Day2.PasswordValidator.valid_toboggan_password_count(
      FileReader.get_input("lib/day_2/input.txt")
    ) == 454
  end

  test "Day 3 - Toboggan Trajectory - part 1" do
    assert Advent.Day3.PathFinder.trees_hit(
      FileReader.get_input("lib/day_3/input.txt")
    ) == 162
  end

  test "Day 3 - Toboggan Trajectory - part 2" do
    assert Advent.Day3.PathFinder.trees_hit_in_more_slopes(
      FileReader.get_input("lib/day_3/input.txt")
    ) == 454
  end

  test "Day 4 - Passport processing - part 1" do
    assert Advent.Day4.PassportValidator.valid_passport_count(
      FileReader.get_input("lib/day_4/input.txt")
    ) == 254
  end

  test "Day 4 - Passport processing - part 2" do
    assert Advent.Day4.PassportValidator.valid_passport_count(
      FileReader.get_input("lib/day_4/input.txt")
    ) == 254
  end

  test "Day 5 - Binary Boarding - part 1" do
    assert Advent.Day5.SeatFinder.highest_id(
      FileReader.get_input("lib/day_5/input.txt")
    ) == 915
  end

  test "Day 5 - Binary Boarding - part 2" do
    assert Advent.Day5.SeatFinder.missing_seat(
      FileReader.get_input("lib/day_5/input.txt")
    ) == 6726
  end


  test "Day 6 - Custom customs - part 1" do
    assert Advent.Day6.ResultCounter.sum_of_yes_answers_in_each_group(
      FileReader.get_input("lib/day_6/input.txt")
    ) == 699
  end

  test "Day 6 - Custom customs - part 2" do
    assert Advent.Day6.ResultCounter.sum_of_unison_yes_answers_in_each_group(
      FileReader.get_input("lib/day_6/input.txt")
    ) == 3316
  end

  test "Day 7 - Handy haversacks - part 1" do
    assert Advent.Day7.HandyHaversacks.can_contain_bag(
      FileReader.get_input("lib/day_7/input.txt"),
      "shiny gold"
    ) |> Enum.count == 161
  end

  test "Day 7 - Handy haversacks - part B" do
    assert Advent.Day7.HandyHaversacks.contains_bag_count(
      FileReader.get_input("lib/day_7/input.txt"),
      "shiny gold"
    ) == 161
  end

  test "Day 8 - Handheld halting - part 1" do
    assert Advent.Day8.HandheldHalting.accumilator_before_inf_loop(
      FileReader.get_input("lib/day_8/input.txt")
    ) == 1782
  end

  test "Day 8 - Handheld halting - part 2" do
    assert Advent.Day8.HandheldHalting.fix_program(
      FileReader.get_input("lib/day_8/input.txt")
    ) == 797
  end

  test "Day 9 - Encoding error - part 1" do
    assert Advent.Day9.EncodingError.failing_number(
      FileReader.get_input("lib/day_9/input.txt")
    ) |> (fn ({number, index}) -> number end).() == 1398413738
  end

  test "Day 9 - Encoding error - part 2" do
    assert Advent.Day9.EncodingError.range_adding_up_to_number(
      FileReader.get_input("lib/day_9/input.txt"),
      Advent.Day9.EncodingError.failing_number(
        FileReader.get_input("lib/day_9/input.txt")
      ) |> (fn ({number, index}) -> number end).()
    ) |> Enum.sum() == 169521051
  end

  test "Day 10 - Adapter array - part 1" do
    assert Advent.Day10.AdapterArray.find_jumps(
      FileReader.get_input("lib/day_10/input.txt")
    ) |> (fn (%{one: one, three: three}) -> one * three end).() == 1398413738
  end

  test "Day 10 - Adapter array - part 2" do
    assert Advent.Day10.AdapterArray.all_possible_combinations_count(
      FileReader.get_input("lib/day_10/input.txt")
    ) == 1398413738
  end

  test "Day 11 - Seating system - part 1" do
    assert Advent.Day11.SeatingSystem.occupied_seats_at_stable(
      FileReader.get_input("lib/day_11/input.txt")
    ) == 1398413738
  end
end
