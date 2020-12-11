defmodule Day7.HandyHaversacksTest do
  use ExUnit.Case
  alias Advent.Day7.Bag
  alias Advent.Day7.HandyHaversacks

  test "it can create a bag from a string" do
    assert Bag.new(
      "dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    ") == %Bag{name: "dark orange", can_contain: [{3, "bright white"}, {4, "muted yellow"}]}
  end

  test "it can create several bags from a string" do
    assert HandyHaversacks.parse_input("
      dim plum bags contain 4 drab coral bags.
      drab beige bags contain 4 wavy crimson bags, 1 dull tan bag, 3 dotted tomato bags.
      wavy crimson bags contain no other bags.
    ") == [
      %Advent.Day7.Bag{
        can_contain: [{4, "drab coral"}],
        name: "dim plum"
      },
      %Advent.Day7.Bag{
        can_contain: [{4, "wavy crimson"}, {1, "dull tan"}, {3, "dotted tomato"}],
        name: "drab beige"
      },
      %Advent.Day7.Bag{
        can_contain: [],
        name: "wavy crimson"
      }
    ]
  end

  test "it can find how many bags a bag contains" do
    assert Advent.Day7.HandyHaversacks.contains_bag_count(
      "shiny gold bags contain 2 dark red bags.
      dark red bags contain 2 dark orange bags.
      dark orange bags contain 2 dark yellow bags.
      dark yellow bags contain 2 dark green bags.
      dark green bags contain 2 dark blue bags.
      dark blue bags contain 2 dark violet bags.
      dark violet bags contain no other bags.",
      "shiny gold"
    ) == 161
  end
end
