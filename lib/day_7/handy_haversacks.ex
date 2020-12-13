defmodule Advent.Day7.Bag do
  defstruct name: :none, can_contain: []

  def new([name, contains] = bag) when is_list(bag) do
    %__MODULE__{
      name: String.trim(name),
      can_contain: contains
        |> String.replace(".", "")
        |> String.split(",")
        |> Enum.map(&String.trim(&1))
        |> Enum.reject(&(&1 == ""))
        |> Enum.map((fn (bag) ->
          quantity = bag |> String.replace(~r/[^\d]/, "")
          name =  bag |> String.replace(~r/[\d]/, "") |> String.trim
          case quantity do
            "" -> nil
            _ -> {quantity |> String.to_integer, name}
          end
        end))
        |> Enum.reject(&(&1 == nil))
    }
  end

  def new(bag) do
    bag
      |> String.trim()
      |> String.replace("bags", "")
      |> String.replace("bag", "")
      |> String.split("contain")
      |> new
  end

  def can_contain?(bag, bags, name) do
    can_contain = bag.can_contain
      |> Enum.any?(fn ({_, bag_name}) -> bag_name == name end)

    case can_contain do
      true -> true
      _ -> can_children_contain?(bag, bags, name)
    end
  end

  def can_children_contain?(bag, bags, name) do
    names = bag.can_contain
      |> Enum.map(fn({_quantity, name}) -> name end)

    case names do
      [] -> false
      _ ->  bags
        |> Enum.filter(&(Enum.member?(names, &1.name)))
        |> Enum.filter(&(can_contain?(&1, bags, name)))
        |> Enum.count()
        |> (fn count -> count > 0 end).()
    end
  end

  def contains_count(bags, name) do
    bag = bags
      |> Enum.find(&(&1.name == name))

    case bag.can_contain do
      [] -> 1
      _ -> bag.can_contain
        |> Enum.map(fn ({quantity, name}) ->
          quantity * contains_count(bags, name)
        end)
        |> Enum.sum
        |> (fn (sum) -> sum + 1 end).()
    end
  end
end

defmodule Advent.Day7.HandyHaversacks do
  alias Advent.Day7.Bag

  def can_contain_bag(input, name) do
    bags = input
      |> parse_input()

    bags
      |> Enum.filter(&(Bag.can_contain?(&1, bags, name)))
  end

  def contains_bag_count(input, name) do
    input
      |> parse_input()
      |> Bag.contains_count(name)
      |> (fn (sum) -> sum - 1 end).()
  end

  def parse_input(input) do
    input
      |> String.trim
      |> String.split("\n")
      |> Enum.map(&(Bag.new(&1)))
  end
end
