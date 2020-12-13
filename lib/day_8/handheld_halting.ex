defmodule Advent.Day8.Instruction do
  defstruct type: '', value: 0

  def new(input) do
    input
      |> String.split(" ")
      |> (fn ([type, value]) ->
        value = value
          |> String.replace("+", "")
          |> String.to_integer()

        %__MODULE__{type: type, value: value}
      end).()
  end

  def new(instruction, value) do
    %__MODULE__{type: instruction, value: value}
  end

  def run_instruction(input, acc, line) do
    instruction = Enum.at(input, line)

    case instruction.type do
      "nop" -> {acc, line + 1}
      "acc" -> {acc + instruction.value, line + 1}
      "jmp" -> {acc, line + instruction.value}
    end
  end
end

defmodule Advent.Day8.HandheldHalting do
  alias Advent.Day8.Instruction
  def parse_input(input) do
    input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.trim(&1))
      |> Enum.map(&Instruction.new(&1))
  end

  def accumilator_before_inf_loop(input) do
    input = input
      |> parse_input()

    {:infinite, acc} = run_program(0, 0, input)

    acc
  end

  def fix_program(input) do
    input = input
      |> parse_input()
      |> Enum.with_index

    input
      |> Enum.map(fn ({instruction, index}) ->
        changed_instruction = case instruction.type do
          "nop" -> Instruction.new("jmp", instruction.value)
          "jmp" -> Instruction.new("nop", instruction.value)
          _ -> instruction
        end

        changed_input = input
          |> Enum.map(fn ({ins, ind}) ->
            case ind == index do
              true -> changed_instruction
              _ -> ins
            end
          end)

          case run_program(0, 0, changed_input) do
            {:infinite, _acc} -> false
            {:done, acc} -> acc
          end
      end)
      |> Enum.reject(&(&1 == false))
      |> List.first
  end

  def run_program(acc, line, input, prev_lines \\ []) do
    {new_acc, new_line} = Instruction.run_instruction(input, acc, line)

    case Enum.member?(prev_lines, new_line) do
      true -> {:infinite, new_acc}
      _ -> case new_line + 1 > Enum.count(input) do
         true -> {:done, new_acc}
         _ -> run_program(new_acc, new_line, input, [new_line | prev_lines])
      end
    end
  end
end
