defmodule Advent.Day4.Passport do
  defstruct byr: "", iyr: "",eyr: "",hgt: "",hcl: "",ecl: "",pid: "", cid: ""

  def new (values) do
    values
      |> String.replace("\n", " ")
      |> String.split(" ")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(fn (value) ->
        [key, val] = String.split(value, ":")
        %{String.to_atom(key) => val}
      end)
      |> Enum.reduce(fn (map, acc) -> Map.merge(map, acc) end)
      |> (fn (map) -> struct(__MODULE__, map) end).()
  end

  def has_all_required_fields?(passport) do

  end

  def is_valid?(%{byr: byr, iyr: iyr, eyr: eyr, hgt: hgt, hcl: hcl, ecl: ecl, pid: pid}) do
    has_valid_birth_year?(byr) && has_valid_issue_year?(iyr) && has_valid_expiration_year?(eyr) &&
    has_valid_height?(hgt) && has_valid_hair_color?(hcl) && has_valid_eye_color?(ecl) && has_valid_passport_id?(pid)
  end

  def has_valid_birth_year?(""), do: false
  def has_valid_birth_year?(year) do
    year = String.to_integer(year)
    IO.inspect(year)
    year >= 1920 and year <= 2002
  end

  def has_valid_issue_year?(""), do: false
  def has_valid_issue_year?(year) do
    year = String.to_integer(year)
    year >= 2010 and year <= 2020
  end

  def has_valid_expiration_year?(""), do: false
  def has_valid_expiration_year?(year) do
    year = String.to_integer(year)
    year >= 2020 and year <= 2030
  end

  def has_valid_height?(""), do: false
  def has_valid_height?(height) do
    number = String.replace(height, ~r/[^\d]+/, "")
      |> String.to_integer()

    case String.replace(height, ~r/\d+/, "") do
       "cm" -> number >= 150 && number <= 193
       "in" -> number >= 59 && number <= 76
       _ -> false
    end

  end

  def has_valid_hair_color?(color) do
    case String.first(color) do
      "#" -> String.length(color) == 7 && String.replace(color, ~r/[^[a-zA-Z0-9]+/, "") |> String.length == 6
      _ -> false
    end
  end

  def has_valid_eye_color?("amb"), do: true
  def has_valid_eye_color?("blu"), do: true
  def has_valid_eye_color?("brn"), do: true
  def has_valid_eye_color?("gry"), do: true
  def has_valid_eye_color?("grn"), do: true
  def has_valid_eye_color?("hzl"), do: true
  def has_valid_eye_color?("oth"), do: true
  def has_valid_eye_color?(_), do: false

  def has_valid_passport_id?(id) do
    only_digits = String.replace(id, ~r/[^\d]/, "")
    String.length(id) == 9 && only_digits |> String.length() == 9
  end
end

defmodule Advent.Day4.PassportValidator do
  alias Advent.Day4.Passport


  def valid_passport_count(input) do
    input
      |> parse_input()
      |> Enum.filter(&(Passport.is_valid?(&1)))
      |> Enum.count
  end

  def parse_input(input) do
    input
      |> String.split("\n\n")
      |> Enum.map(&(String.trim(&1)))
      |> Enum.map(&(Passport.new(&1)))
  end
end
