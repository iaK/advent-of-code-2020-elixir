defmodule Advent.Day6.Person do
  defstruct yeses: []

  def new(input) do
    yeses = input
      |> String.trim()
      |> String.split("")
      |> Enum.reject(&(&1 == ""))
    %__MODULE__{yeses: yeses}
  end
end

defmodule Advent.Day6.CustomsGroup do
  alias Advent.Day6.Person
  defstruct people: []

  def new(people) do
    people
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&(Person.new(&1)))
      |> (fn (people) -> %__MODULE__{people: people} end).()
  end

  def questions_anyone_answered_yes_to(group) do
    group.people
      |> Enum.flat_map(&(&1.yeses))
      |> Enum.uniq()
  end

  def questions_everyone_answered_yes_to(group) do
    group.people
      |> Enum.map(&(&1.yeses))
      |> IO.inspect
      |> Enum.reduce(fn (person, acc) ->
        MapSet.intersection(Enum.into(person, MapSet.new), Enum.into(acc, MapSet.new))
      end)
  end

end


defmodule Advent.Day6.ResultCounter do
  alias Advent.Day6.CustomsGroup
  alias Advent.Day6.Person

  def sum_of_yes_answers_in_each_group(input) do
    input
      |> parse_input()
      |> Enum.map(&(CustomsGroup.questions_anyone_answered_yes_to(&1)))
      |> Enum.map(&(Enum.count(&1)))
      |> Enum.sum()
  end

  def sum_of_unison_yes_answers_in_each_group(input) do
    input
      |> parse_input()
      |> Enum.map(&(CustomsGroup.questions_everyone_answered_yes_to(&1)))
      |> Enum.map(&(Enum.count(&1)))
      |> Enum.sum()
  end

  def parse_input(input) do
    input
      |> String.trim
      |> String.split("\n\n")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&(CustomsGroup.new(&1)))
  end
end
