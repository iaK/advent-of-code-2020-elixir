defmodule Advent.NewDay do
  def new(day, name) do
    file_name = name
     |> String.downcase()
     |> String.replace(" ", "_")
     |> (fn (string) -> string <> ".ex" end).()

    test_name = name
      |> String.downcase()
      |> String.replace(" ", "_")
      |> (fn (string) -> string <> "_test.exs" end).()

    File.write!("/lib/day_" <> Integer.to_string(day) <> "/" <> file_name, get_template(day, name))
    File.write!("/lib/day_" <> Integer.to_string(day) <> "/input.txt", "")
    File.write!("/test/day_" <> Integer.to_string(day) <> "/" <> test_name, get_test_template(day, name))
  end

  def get_template(day, name) do
    module_name = name
      |> String.capitalize()
      |> String.replace(" ", "")

    "
defmodule Advent.Day" <> Integer.to_string(day) <> "." <> module_name <> " do

end
    " |> String.trim()
  end

  def get_test_template(day, name) do
    module_name = name
      |> String.capitalize()
      |> String.replace(" ", "")

    "
defmodule Advent.Day" <> Integer.to_string(day) <> "." <> module_name <> "Test do
  use ExUnit.Case
  alias Advent.Day" <> Integer.to_string(day) <> "." <> module_name <> "
  alias Advent.Day8.HandheldHalting
end
    " |> String.trim()
  end
end
