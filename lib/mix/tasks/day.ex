defmodule Mix.Tasks.Day do
  use Mix.Task

  @impl Mix.Task
  def run([day, name]) do
    file_name = name
     |> String.downcase()
     |> String.replace(" ", "_")
     |> (fn (string) -> string <> ".ex" end).()

    test_name = name
      |> String.downcase()
      |> String.replace(" ", "_")
      |> (fn (string) -> string <> "_test.exs" end).()

    File.mkdir!("lib/day_" <> day)
    File.mkdir!("test/day_" <> day)
    File.write!("lib/day_" <> day <> "/" <> file_name, get_template(day, name))
    File.write!("lib/day_" <> day <> "/input.txt", "")
    File.write!("test/day_" <> day <> "/" <> test_name, get_test_template(day, name))
  end

  def get_template(day, name) do
    module_name = name
      |> String.split(" ")
      |> Enum.map(&(String.capitalize(&1)))
      |> Enum.join

    "
defmodule Advent.Day" <> day <> "." <> module_name <> " do

end
    " |> String.trim()
  end

  def get_test_template(day, name) do
    module_name = name
      |> String.split(" ")
      |> Enum.map(&(String.capitalize(&1)))
      |> Enum.join

    "
defmodule Advent.Day" <> day <> "." <> module_name <> "Test do
  use ExUnit.Case
  alias Advent.Day" <> day <> "." <> module_name <> "

end
    " |> String.trim()
  end
end
