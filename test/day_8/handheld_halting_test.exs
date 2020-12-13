defmodule Day8.HandheldHaltingTest do
  use ExUnit.Case
  alias Advent.Day8.Instruction
  alias Advent.Day8.HandheldHalting

  test "it can create instructions from input" do
    assert HandheldHalting.parse_input("
      nop +0
      acc +1
      jmp -4
    ") == [
        %Advent.Day8.Instruction{type: "nop", value: 0},
        %Advent.Day8.Instruction{type: "acc", value: 1},
        %Advent.Day8.Instruction{type: "jmp", value: -4}
    ]
  end

  test "it can run the program until it detects an infinite loop" do
    assert HandheldHalting.accumilator_before_inf_loop("
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
    ") == 5
  end

end
