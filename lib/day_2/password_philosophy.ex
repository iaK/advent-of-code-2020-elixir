defmodule Advent.Day2.PasswordValidator do
  defstruct char: "", range: 0..0, password: ""

  def valid_toboggan_password_count(input) do
    input
      |> parse_input()
      |> Enum.filter(&(is_valid_toboggan?(&1)))
      |> Enum.count
  end
  def valid_sled_rental_password_count(input) do
    input
      |> parse_input()
      |> Enum.filter(&(is_valid_sled_rental?(&1)))
      |> Enum.count
  end

  def is_valid_sled_rental?(number, min..max) when number in min..max, do: true
  def is_valid_sled_rental?(number, min..max) when number not in min..max, do: false
  def is_valid_sled_rental?(%__MODULE__{char: char, range: range, password: password}) do
    password
      |> String.replace(~r/[^#{char}]*/, "")
      |> String.length()
      |> is_valid_sled_rental?(range)
  end

  def is_valid_toboggan?(a,[a,a]), do: false
  def is_valid_toboggan?(a,[_b,a]), do: true
  def is_valid_toboggan?(a,[a,_b]), do: true
  def is_valid_toboggan?(_a,[_b,_c]), do: false
  def is_valid_toboggan?(%__MODULE__{char: char, range: first..second, password: password}) do
    is_valid_toboggan?(char, [String.at(password, first - 1), String.at(password, second - 1)])
  end

  def parse_input(input) do
    input
      |> String.trim
      |> String.split("\n")
      |> Enum.map(&(String.trim(&1)))
      |> Enum.map(&(parse_row(&1)))
  end

  def parse_row(row) do
    [range, char, password] = row
      |> String.split(" ")

    [first, last] = range |> String.split("-")

    %__MODULE__{
      char: char |> String.replace(":", ""),
      range: Range.new(String.to_integer(first), String.to_integer(last)),
      password: password
    }
  end
end
