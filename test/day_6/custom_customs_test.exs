defmodule Day6.CustomCustomsTest do
  use ExUnit.Case
  alias Advent.Day6.ResultCounter

  test "it can parse the input" do
    groups = ResultCounter.parse_input("
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
    ")

    assert groups == [
      %Advent.Day6.CustomsGroup{
        people: [%Advent.Day6.Person{yeses: ["a", "b", "c"]}]
      },
      %Advent.Day6.CustomsGroup{
        people: [
          %Advent.Day6.Person{yeses: ["a"]},
          %Advent.Day6.Person{yeses: ["b"]},
          %Advent.Day6.Person{yeses: ["c"]}
        ]
      },
      %Advent.Day6.CustomsGroup{
        people: [
          %Advent.Day6.Person{yeses: ["a", "b"]},
          %Advent.Day6.Person{yeses: ["a", "c"]}
        ]
      },
      %Advent.Day6.CustomsGroup{
        people: [
          %Advent.Day6.Person{yeses: ["a"]},
          %Advent.Day6.Person{yeses: ["a"]},
          %Advent.Day6.Person{yeses: ["a"]},
          %Advent.Day6.Person{yeses: ["a"]}
        ]
      },
      %Advent.Day6.CustomsGroup{people: [%Advent.Day6.Person{yeses: ["b"]}]}
    ]
  end
end
