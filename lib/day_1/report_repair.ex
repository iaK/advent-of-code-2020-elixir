defmodule Advent.Day1.Adder do
  defstruct number: 0, adds: []

  def add(add, %__MODULE__{number: number, adds: adds}) when is_number(add) do
    %__MODULE__{number: number, adds: [add | adds]}
  end

  def add(_item, []) do
    []
  end

  def add(item, collection) do
    collection
      |> Enum.map(&(add(&1, item)))
  end

  def sum(%__MODULE__{number: _, adds: adds}) do
    Enum.sum(adds)
  end
end

defmodule Advent.Day1.ReportRepair do
  alias Advent.Day1.Adder

  def find_expense_product(input, should_sum_to, levels) do
    expenses = input
      |> parse_input

    expenses
      |> Enum.map(&(%Adder{number: &1, adds: [&1]}))
      |> sum(levels - 1)
      |> Enum.filter(&(Adder.sum(&1) == should_sum_to))
      |> List.first()
      |> (fn (adder) -> Enum.reduce(adder.adds, fn (elem, acc) -> elem * acc end) end).()
  end

    def sum(expenses, level) do
      numbers = expenses
        |> Enum.map(&(&1.number))
        |> Enum.uniq()

      sums = expenses
        |> Enum.flat_map(&(Adder.add(&1, numbers)))

        case level == 1 do
          true -> sums
          _ -> sum(sums, level - 1)
        end
    end

    def parse_input(input) do
      input
        |> String.split("\n")
        |> Enum.map(&(String.trim(&1)))
        |> Enum.reject(&(&1 == ""))
        |> Enum.map(&(String.to_integer(&1)))
    end
end
